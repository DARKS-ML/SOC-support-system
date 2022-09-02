from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets

from soc.processing import AuthLogDataProcessing

from .processing import IDSLogDataProcessing
import pandas as pd
import numpy as np

import glob
import os
import time

import os.path as path
import pickle


base_path =  path.abspath(path.join(__file__ ,"../../.."))
ids_model_path =base_path+'/Models Collection/ids/'
ids_predicted_base_path = base_path+'/dashboard/Predicted Results/ids/'
ids_predicted_csv_path = base_path+'/dashboard/Predicted Results/ids/'
ids_predicted_json_path = base_path+'/dashboard/Predicted Results/ids/'
notification_path = base_path+'/dashboard/Predicted Results/'
dataset_collection = base_path+'/Dataset/ids/'


# @desc -> get list of files from specific log containg directory  
class IDSLogFileDetailsView(APIView):
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


# @desc -> get list of files from specific log containg directory  
class PredictedIDSFileDetailsView(APIView):
    def get(self,request):
        dir_name = ids_predicted_json_path
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



# @desc -> list all directory and sub directory name 
class ListAllPredictedModelResult(APIView):
    def get(self,request):

        dir_name = ids_predicted_json_path
        
        path = dir_name
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
        

        # ==============================
        #  all files at onces 
        # --------------------------------
        files_list = []
        root = ids_predicted_json_path
        for path, subdirs, files in os.walk(root):
            for name in files:
                paths_list = os.path.join(path, name)
                if paths_list.endswith(".json"):
                    files_list.append(paths_list)

        # ==============================


        return Response({
            "files":files_list,
            "data":data,
        })
        

    
# Create your views here.
class IDSLogView(APIView):
    def post(self,request):
        request_data = request.data

        try:
            final_path = request_data["path"]
            if final_path.endswith('.log'):
                return Response("Log File",status=status.HTTP_406_NOT_ACCEPTABLE)
            elif final_path.endswith('.csv'):
                filewiseFolder = final_path.split("/ids/")[1].replace(".csv","")
                # ////////////////start ////////////////
                ref = IDSLogDataProcessing()

                data =ref.dfAppendClean(final_path)

                # if ' Label' in data.columns:
                #     data = data.drop(' Label',axis=1)

                p_df = data.copy()

                # create folder
                import shutil
                daywisefolderName = filewiseFolder

                # daywisefolderName = ref.fileNameFormat("ids")
                daywisefolderPath =  os.path.join(ids_predicted_base_path, daywisefolderName)
                if os.path.exists(daywisefolderPath):
                    shutil.rmtree(daywisefolderPath)
                os.mkdir(daywisefolderPath)
                
                
            

                model_name = "FTPPatator"
                df_FTPPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_FTPPatator_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_FTPPatator_benign_", df_FTPPatator_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

            
                model_name = "SSHPatator"
                df_SSHPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_SSHPatator_benign.sav")
                p_df =  ref.predict_ids_attack(ids_model_path+"IDS"+"df_SSHPatator_benign_", df_SSHPatator_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
    
                model_name="DoS_Slowhttptest"
                df_DoS_Slowhttptest_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Slowhttptest_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_DoS_Slowhttptest_benign_", df_DoS_Slowhttptest_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="DoS_Hulk"
                df_DoS_Hulk_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Hulk_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_DoS_Hulk_benign_", df_DoS_Hulk_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="DoS_GoldenEye"
                df_DoS_GoldenEye_benign= ref.load_feature_importance(data, ids_model_path+"df_DoS_GoldenEye_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_DoS_GoldenEye_benign_", df_DoS_GoldenEye_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
                
                model_name="Heartbleed"
                df_Heartbleed_benign = ref.load_feature_importance(data, ids_model_path+"df_Heartbleed_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Heartbleed_benign_", df_Heartbleed_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_Brute_Force"
                df_Web_Attack_Brute_Force_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Brute_Force_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Web_Attack_Brute_Force_benign_", df_Web_Attack_Brute_Force_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_XSS_benign"
                df_Web_Attack_XSS = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_XSS_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Web_Attack_XSS_benign_", df_Web_Attack_XSS,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_Sql_Injection"
                df_Web_Attack_Sql_Injection_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Sql_Injection_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Web_Attack_Sql_Injection_benign_", df_Web_Attack_Sql_Injection_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Infiltration"
                df_Infiltration_benign = ref.load_feature_importance(data, ids_model_path+"df_Infiltration_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Infiltration_benign_", df_Infiltration_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
                
                model_name="Bot"
                df_Bot_benign = ref.load_feature_importance(data, ids_model_path+"df_Bot_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Bot_benign_", df_Bot_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="PortScan"
                df_PortScan_benign = ref.load_feature_importance(data, ids_model_path+"df_PortScan_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_PortScan_benign_", df_PortScan_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="df_DDoS_benign"
                df_DDoS_benign = ref.load_feature_importance(data, ids_model_path+"df_DDoS_benign.sav")
                p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_DDoS_benign_", df_DDoS_benign,model_name,final_path)
                ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                # model_name="df_Web_Attack"
                # df_Web_Attack_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_benign.sav")
                # p_df = ref.predict_ids_attack(ids_model_path+"IDS"+"df_Web_Attack_benign_", df_Web_Attack_benign,model_name,final_path)
                # ref.createModelCsvJsonFolder(daywisefolderPath,model_name,p_df,daywisefolderName)
                # # ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
            
                # p_df.to_csv(ids_predicted_csv_path+"sample.csv")
                

              
                
                return Response ({
                            "msg":"please visit",
                            "base_path":ids_predicted_base_path
                        })
                # ////////////////end ////////////////

            else:
                return Response({
             "error":   "file is not accepted (only .log and .csv)"
            },
            status=status.HTTP_406_NOT_ACCEPTABLE)
            return Response(final_path,status=status.HTTP_406_NOT_ACCEPTABLE)

        except Exception as e:
            return Response({
            "error":f"{type(e).__name__} was raised: {e}",

            },status=status.HTTP_406_NOT_ACCEPTABLE)

        return Response({
             "error":   "path is not valid input"
            },
            status=status.HTTP_406_NOT_ACCEPTABLE)


class MultiClassPrediction(APIView):
    def post(self,request):
        try:
            request_data = request.data
            final_path = request_data["path"]
            if final_path.endswith('.csv'):
                ref = IDSLogDataProcessing()

                multiclass_model_load =  pickle.load(open(ids_model_path+'IDS_multiclass.sav','rb'))
                data_to_predict = pd.read_csv(final_path)

                column_to_remove = ['Flow ID',' Source IP',' Source Port',' Destination IP',' Protocol',' Timestamp']
                data = data_to_predict.drop(column_to_remove , axis=1)
                data = data.fillna(0)
                # data[' Label'] = data[' Label'].str.replace(r'[^\w\s]+', '')
                data = data.replace([np.inf, -np.inf], 0)
                if ' Label' in data.columns:
                    data = data.drop(' Label',axis=1)  

                if 'Label' in data.columns:
                    data = data.drop(' Label',axis=1) 
                
                model_out = multiclass_model_load.predict(data)
                model_probab = multiclass_model_load.predict_proba(data)
                # multiclass_model_load.classes_
                model_probab_df = pd.DataFrame(model_probab)
                attack_column_name = ['BENIGN', 'Bot', 'DDoS', 'DoS GoldenEye', 'DoS Hulk','DoS Slowhttptest', 'DoS slowloris', 'FTPPatator', 'Heartbleed','Infiltration', 'PortScan', 'SSHPatator','Web Attack  Brute Force', 'Web Attack  Sql Injection','Web Attack  XSS']
                model_probab_df.columns = attack_column_name

                model_probab_df["max"] = model_probab_df.max(axis=1)
                model_probab_df["type"] = model_probab_df.idxmax(axis=1)
                new = data_to_predict[[' Source IP',' Source Port',' Destination IP',' Timestamp']].join(model_probab_df)
               
                df = new[new["type"].str.contains("BENIGN") == False]
                column_to_remove_from_df = attack_column_name

                df = df.drop(column_to_remove_from_df,axis=1)
                # convert to csv
                # cretae base Notification folder ->done
                notf_base_path = os.path.join(notification_path,"Notification")
                if not os.path.exists(notf_base_path):             
                    os.makedirs(notf_base_path)

                notification_date = ref.fileNameFormat("notif")
                notification_date_path = os.path.join(notf_base_path,notification_date)
                if not os.path.exists(notification_date_path):             
                    os.makedirs(notification_date_path)
                
                notification_name = ref.fileNameFormat("ids_multiclass_notf")
                notif_csv_file_path = f'{notification_date_path}/{notification_name}.csv'
                df.to_csv(notif_csv_file_path,index=False,header=True)

                notif_json_data = ref.convertCsvToJson(notif_csv_file_path)
                import json
                notf_json_object = json.dumps(notif_json_data, indent = 4)

                notif_json_file_path = f'{notification_date_path}/{notification_name}.json'
                with open(notif_json_file_path, "w") as outfile:
                    outfile.write(notf_json_object)


                return Response({
                    "csv_path":notif_csv_file_path,
                    "json_path":notif_json_file_path
                })

        except Exception as e: 
            return Response({
                "error":f"{type(e).__name__} was raised: {e}",
            },
            status=status.HTTP_400_BAD_REQUEST)

               
class GroupBy(APIView):
    def get(self,request):
        try:
            csv_path = request.GET.get("csv_path")
            if csv_path.endswith('.csv'):
                df = pd.read_csv(csv_path)
                sourceIp = df.groupby([' Source IP','type']).count()
                sourceIp.reset_index(inplace=True)

                destIp = df.groupby([' Destination IP','type']).count()
                destIp.reset_index(inplace=True)

                sourcePort = df.groupby([' Source Port','type']).count()
                sourcePort.reset_index(inplace=True)

                ref = AuthLogDataProcessing()
                import json

                groupby_base_path = os.path.join(notification_path,"Groupby")
                if not os.path.exists(groupby_base_path):             
                    os.makedirs(groupby_base_path)
                
                groupby_name = "group_by_"

                # source ip json
                groupby_sourceip_csv_file_path = f'{groupby_base_path}/{groupby_name}source_ip.csv'
                sourceIp.to_csv(groupby_sourceip_csv_file_path,index=False,header=True)

                groupby_sourceip_json_data = ref.convertCsvToJson(groupby_sourceip_csv_file_path)
                groupby_sourceip_json_object = json.dumps(groupby_sourceip_json_data, indent = 4)

                groupby_sourceip_json_file_path = f'{groupby_base_path}/{groupby_name}source_ip.json'
                with open(groupby_sourceip_json_file_path, "w") as outfile:
                    outfile.write(groupby_sourceip_json_object)

                # dest ip
                # source ip json
                groupby_descip_csv_file_path = f'{groupby_base_path}/{groupby_name}desc_ip.csv'
                destIp.to_csv(groupby_descip_csv_file_path,index=False,header=True)

                groupby_descip_json_data = ref.convertCsvToJson(groupby_descip_csv_file_path)
                groupby_descip_json_object = json.dumps(groupby_descip_json_data, indent = 4)

                groupby_descip_json_file_path = f'{groupby_base_path}/{groupby_name}desc_ip.json'
                with open(groupby_descip_json_file_path, "w") as outfile:
                    outfile.write(groupby_descip_json_object)


                 # source port ip
                # source ip json
                groupby_sourceport_csv_file_path = f'{groupby_base_path}/{groupby_name}source_port.csv'
                sourcePort.to_csv(groupby_sourceport_csv_file_path,index=False,header=True)

                groupby_sourceport_json_data = ref.convertCsvToJson(groupby_sourceport_csv_file_path)
                groupby_sourceport_json_object = json.dumps(groupby_sourceport_json_data, indent = 4)

                groupby_sourceport_json_file_path = f'{groupby_base_path}/{groupby_name}source_port.json'
                with open(groupby_sourceport_json_file_path, "w") as outfile:
                    outfile.write(groupby_sourceport_json_object)
                # group_by_path = csv_path.split(".csv")[0]+"_group_by_"

               
                return Response({
                    "source_ip":sourceIp.to_json(),
                    "destination_ip":destIp.to_json(),
                    "soure_port":sourcePort.to_json()
                    })
            return Response({
                    "error":"failed to load data",
                    },
                    status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({
            "error":f"{type(e).__name__} was raised: {e}",
            "hint":"localhost/?csv_path=multiclass_output_csv_file_path.csv"
            },
            status=status.HTTP_400_BAD_REQUEST)  