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

import os.path as path

modulePath = os.path.dirname(__file__)
base_path =  path.abspath(path.join(__file__ ,"../../.."))
auth_model_path =base_path+'/Models Collection/auth/'
auth_predicted_csv_path = base_path+'/dashboard/Predicted Results/Auth Log/csv/'
auth_predicted_json_path = base_path+'/dashboard/Predicted Results/Auth Log/json/'
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


# @desc -> get path of log file
# http://127.0.0.1:8000/api/v1/csv/?path=%22Hello%22
class MultiLineAuthLogView(APIView):
    def get(self,request):
        return Response({
            "msg":"enter your file path"
        })
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

                file_name =ref.fileNameFormat("auth")
                csv_file_path = f'{auth_predicted_csv_path}/{file_name}.csv'
                df_copy1.to_csv(csv_file_path,index=False,header=True)
                
                import json
                json_data = ref.convertCsvToJson(csv_file_path)
                
                json_object = json.dumps(json_data, indent = 4)
                file_name =ref.fileNameFormat("auth")
                json_file_path = f'{auth_predicted_json_path}/{file_name}.json'
                with open( json_file_path, "w") as outfile:
                    outfile.write(json_object)
                

                return Response ({
                    "csv_path":csv_file_path,
                    "json_path":json_file_path
                })
            elif final_path.endswith('.csv'):
                return Response ("Csv File")
            else:
                return Response ("Not formated file")
          
        except Exception as e:
            return Response({
             "error":   e
            })

    