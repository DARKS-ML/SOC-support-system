# from traceback import print_tb
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets
from .serializers import MultiLineAuthLogSerializer
from .processing import AuthLogDataProcessing
import joblib
import pandas as pd

import glob
import os
import time
import json


import os.path as path

modulePath = os.path.dirname(__file__)
base_path =  path.abspath(path.join(__file__ ,"../../.."))
auth_model_path =base_path+'/Models Collection/auth/'
auth_predicted_csv_path = base_path+'/dashboard/Predicted Results/Auth Log/'
auth_predicted_json_path = base_path+'/dashboard/Predicted Results/Auth Log/'
notification_path = base_path+'/dashboard/Predicted Results/'
dataset_collection = base_path+'/Dataset/auth/'

# Create your views here.

# @desc -> predict single log line 
class SingleLineAuthenticationLogView(APIView):      
    def post(self, request):
        input_log = request.data
        ref = AuthLogDataProcessing()
        data1 = ref.authParserLine(input_log)
        df1 = ref.convertToDataFrame(data1)
        df1_clean = ref.clean(df1, "event")
        stopwords1 = ['pam_unixcronsession' 'by', 'string', 'from',
                      'bye', 'for', 'port', 'sshd', 'ssh', 'root', 'preauth']
        df1_clean = ref.remStopWord(df1_clean, "event", stopwords1)
        path =modulePath+"/mlmodels/auth_system/"

        # model time
        loaded_vectorizer = joblib.load(auth_model_path + "auth_vectorizer_model.joblib")
        
        
        vector_op1 = loaded_vectorizer.transform(df1_clean['event'])
        loaded_pca = joblib.load(auth_model_path + "auth_pca_model.joblib")
        pca_data1 = loaded_pca.transform(vector_op1.todense())

        loaded_model_kmeans =  joblib.load(auth_model_path + "auth_kmeans_model.joblib")
        model_data1 = loaded_model_kmeans.predict(pca_data1)

        loaded_model2 = joblib.load(auth_model_path + 'auth_sgd_model.joblib')
        vector_op1_df = ref.convertToDataFrame(vector_op1.todense())
        model_data2 = loaded_model2.predict(vector_op1_df)
        list = model_data2.tolist()[0]

        requested_log = request.data
      
        return Response({
            "log":requested_log,
            "label":list
        })


# @desc -> get list of files from specific log containg directory  
class AuthLogFileDetailsView(APIView):
    def get(self,request):
        dir_name = dataset_collection
        my_dict = {}
        data = []
        # Get list of all files only in the given directory
        list_of_files = filter(os.path.isfile,glob.glob(dir_name + '*'))
        # Sort list of files based on last modification time in ascending order
        list_of_files = sorted(list_of_files,key = os.path.getmtime,reverse=True)
        # Iterate over sorted list of files and print file path 
        # along with last modification time of file 
        for file_path in list_of_files:
            timestamp_str = time.strftime( "%Y-%m-%d %H:%M:%S",
                                            time.gmtime(os.path.getmtime(file_path))) 
            my_dict = {
                "date":timestamp_str,
                "path":file_path
            }
            data.append(my_dict)
        # return Response(my_dict)
        return Response(data)



class PredictedAuthFileDetailsView(APIView):
    def get(self,request):
        dir_name = auth_predicted_json_path+"json/"
        my_dict = {}
        data = []
        # Get list of all files only in the given directory
        list_of_files = filter(os.path.isfile,glob.glob(dir_name + '*'))
        # Sort list of files based on last modification time in ascending order
        list_of_files = sorted(list_of_files,key = os.path.getmtime,reverse=True)
        # Iterate over sorted list of files and print file path 
        # along with last modification time of file 
        for file_path in list_of_files:
            timestamp_str = time.strftime( "%Y-%m-%d %H:%M:%S",
                                            time.gmtime(os.path.getmtime(file_path))) 
            my_dict = {
                "date":timestamp_str,
                "path":file_path
            }
            data.append(my_dict)
        # return Response(my_dict)
        return Response(data)

# @desc -> get path of log file
# http://127.0.0.1:8000/api/v1/csv/?path=%22Hello%22
class MultiLineAuthLogView(APIView):
    def get(self,request):      
        return Response({
            "msg":"enter your file path"
        },status=status.HTTP_404_NOT_FOUND)
    # here /home/iamdpk/Project Work/SOC-support-system/Dataset/auth.log
    def post(self,request):
        request_data =  request.data
        try:
            final_path = request_data["path"]
            if final_path.endswith('.log'):
                ref = AuthLogDataProcessing()
                data1 = ref.autLogFileParser(final_path)
                df1 = pd.DataFrame(data1)
                df_copy1 = df1.copy()
                df1_clean = ref.clean(df1,"event")

                stopwords1 = ['pam_unixcronsession' 'by', 'string', 'from', 'bye', 'for', 'port', 'sshd', 'ssh', 'root', 'preauth']
                df1_clean = ref.remStopWord(df1_clean, "event", stopwords1)
                 
                # model time
                loaded_vectorizer = joblib.load(auth_model_path + "auth_vectorizer_model.joblib")
                vector_op1 = loaded_vectorizer.transform(df1_clean['event'])

                loaded_pca = joblib.load(auth_model_path + "auth_pca_model.joblib")
                pca_data1 = loaded_pca.transform(vector_op1.todense())

                loaded_model_kmeans = joblib.load(auth_model_path + "auth_kmeans_model.joblib")
                distance1 = ref.fromCentDistance(pca_data1, loaded_model_kmeans)
                
                df_copy1['distance'] = distance1
                df_copy1['label'] = loaded_model_kmeans.labels_
                mod_zscore, mad = ref.modified_zscore(df_copy1['distance'])
                df_copy1['mod_zscore'] = mod_zscore.tolist()

                import shutil
                csv_f = "csv"
                csv_path = os.path.join(auth_predicted_csv_path,csv_f)
                if os.path.exists(csv_path):
                        shutil.rmtree(csv_path)
                os.mkdir(csv_path)

                file_name =ref.fileNameFormat("auth")
                csv_file_path = f'{csv_path}/{file_name}.csv'
                df_copy1.to_csv(csv_file_path,index=False,header=True)


                # prediction event 
                json_data = ref.convertCsvToJson(csv_file_path)
                
                json_object = json.dumps(json_data, indent = 4)
                file_name =ref.fileNameFormat("auth")
                json_f = "json"
                json_path = os.path.join(auth_predicted_json_path,json_f)
                if os.path.exists(json_path):
                        shutil.rmtree(json_path)
                os.mkdir(json_path)
                json_file_path = f'{json_path}/{file_name}.json'
                with open( json_file_path, "w") as outfile:
                    outfile.write(json_object)

                # =======================================#
                #       Notification related work
                # =======================================#

                df_nf = pd.read_csv(csv_file_path)
                df_nf = df_nf.drop(["date","time","distance","mod_zscore"],axis=1)
                # notif = df_nf.loc[df_nf['distance'] > 0.6]
                # notif['event'] = notif['event'].str.replace("\n","")
                notif = df_nf.loc[df_nf['label'] > 3]
                notif = notif.groupby(['ip','event','label']).count()
                notif.reset_index(inplace=True)
                notif = notif.sort_values(by=['process'], ascending=False)
                # notif['count'] = notif(["process"])
                notif.rename(columns = {'process':'count'}, inplace = True)
                notif['event'] = notif['event'].str.replace("\n","")
                
                # cretae base Notification folder ->done
                notf_base_path = os.path.join(notification_path,"Notification")
                if not os.path.exists(notf_base_path):             
                    os.makedirs(notf_base_path)

                notification_date = ref.fileNameFormat("notif")
                notification_date_path = os.path.join(notf_base_path,notification_date)
                if not os.path.exists(notification_date_path):             
                    os.makedirs(notification_date_path)
                
                notification_name = ref.fileNameFormat("auth_notf")
                notif_csv_file_path = f'{notification_date_path}/{notification_name}.csv'
                notif.to_csv(notif_csv_file_path,index=False,header=True)

                notif_json_data = ref.convertCsvToJson(notif_csv_file_path)
                notf_json_object = json.dumps(notif_json_data, indent = 4)

                notif_json_file_path = f'{notification_date_path}/{notification_name}.json'
                with open(notif_json_file_path, "w") as outfile:
                    outfile.write(notf_json_object)


                # =======================================#
                #       Notification related work End
                # =======================================#

               
                

                return Response ({
                    "csv_path":csv_file_path,
                    "json_path":json_file_path
                })

            elif final_path.endswith('.csv'):
                return Response ("Csv File",status=status.HTTP_406_NOT_ACCEPTABLE)
            else:
                return Response ("Not formated file",status=status.HTTP_406_NOT_ACCEPTABLE)
          
        except Exception as e:
            return Response({
             "error":e
            },status=status.HTTP_412_PRECONDITION_FAILED)


# @desc -> list all directory and sub directory name 
class NotificationResult(APIView):
    def get(self,request):

        dir_name = notification_path+"Notification/"
        dir_name_groupby = notification_path+"Groupby/"
        
        path = dir_name
        groupby_path = dir_name_groupby

        def tree_path_json(path):
            dir_structure = {}
            base_name = os.path.basename(os.path.realpath(path))
            if os.path.isdir(path):
                dir_structure[base_name] = [ tree_path_json(os.path.join(path, file_name))\
                for file_name in os.listdir(path) ]
            else:
                return os.path.abspath(path)
            return dir_structure
        data = tree_path_json(path)
        groupby = tree_path_json(groupby_path)
        return Response({
            "data":data,
            "groupby":groupby,
        })
        

   