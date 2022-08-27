from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response

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

        path = "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/"
        def tree_path_json(path):
            dir_structure = {}
            base_name = os.path.basename(os.path.realpath(path))
            if os.path.isdir(path):
                dir_structure[base_name] = [ tree_path_json(os.path.join(path, file_name))\
                for file_name in os.listdir(path) ]
            else:
                return os.path.basename(path)
            return dir_structure
        data = tree_path_json(path)
        return Response({
            "data":data
        })
        

    
# Create your views here.
class IDSLogView(APIView):
    def post(self,request):
        request_data = request.data

        try:
            final_path = request_data["path"]
            if final_path.endswith('.log'):
                return Response("Log File")
            elif final_path.endswith('.csv'):
                # ////////////////start ////////////////
                ref = IDSLogDataProcessing()

                data =ref.dfAppendClean(final_path)

                data = data.drop(' Label',axis=1)

                p_df = data.copy()

                model_name = "FTPPatator"
                df_FTPPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_FTPPatator_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_FTPPatator_benign_logic_model.sav", df_FTPPatator_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
            
                model_name = "SSHPatator"
                df_SSHPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_SSHPatator_benign.sav")
                p_df =  ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_SSHPatator_benign_logic_model.sav", df_SSHPatator_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
                
                model_name="DoS_Slowhttptest"
                df_DoS_Slowhttptest_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Slowhttptest_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_Slowhttptest_benign_logic_model.sav", df_DoS_Slowhttptest_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="DoS_Hulk"
                df_DoS_Hulk_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Hulk_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_Hulk_benign_logic_model.sav", df_DoS_Hulk_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="DoS_GoldenEye"
                df_DoS_GoldenEye_benign= ref.load_feature_importance(data, ids_model_path+"df_DoS_GoldenEye_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_GoldenEye_benign_logic_model.sav", df_DoS_GoldenEye_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
                
                model_name="Heartbleed"
                df_Heartbleed_benign = ref.load_feature_importance(data, ids_model_path+"df_Heartbleed_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Heartbleed_benign_logic_model.sav", df_Heartbleed_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_Brute_Force"
                df_Web_Attack_Brute_Force_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Brute_Force_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_Brute_Force_benign_logic_model.sav", df_Web_Attack_Brute_Force_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_XSS_benign"
                df_Web_Attack_XSS = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_XSS_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_XSS_benign_logic_model.sav", df_Web_Attack_XSS,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Web_Attack_Sql_Injection"
                df_Web_Attack_Sql_Injection_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Sql_Injection_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_Sql_Injection_benign_logic_model.sav", df_Web_Attack_Sql_Injection_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="Infiltration"
                df_Infiltration_benign = ref.load_feature_importance(data, ids_model_path+"df_Infiltration_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Infiltration_benign_logic_model.sav", df_Infiltration_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
                
                model_name="Bot"
                df_Bot_benign = ref.load_feature_importance(data, ids_model_path+"df_Bot_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Bot_benign_logic_model.sav", df_Bot_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="PortScan"
                df_PortScan_benign = ref.load_feature_importance(data, ids_model_path+"df_PortScan_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_PortScan_benign_logic_model.sav", df_PortScan_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="df_DDoS_benign"
                df_DDoS_benign = ref.load_feature_importance(data, ids_model_path+"df_DDoS_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DDoS_benign_logic_model.sav", df_DDoS_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)

                model_name="df_Web_Attack"
                df_Web_Attack_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_benign.sav")
                p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_benign_logic_model.sav", df_Web_Attack_benign,model_name)
                ref.createDirectoryAndFileAsPerModelName(ids_predicted_base_path,model_name,p_df)
            
                # p_df.to_csv(ids_predicted_csv_path+"sample.csv")
                

              
                
                return Response ({
                            "msg":"please visit",
                            "base_path":ids_predicted_base_path
                        })
                # ////////////////end ////////////////

            else:
                return Response({
             "error":   "file is not accepted (only .log and .csv)"
            })
            return Response(final_path)

        except :
            return Response({
             "error":   "path required"
            })

        return Response({
             "error":   "path is not valid input"
            })

    # def post(self,request):
    #     requested_data = request.data
      

    #     ref = IDSLogDataProcessing()

    #     data =ref.dfAppendClean(requested_data)

    #     data = data.drop(' Label',axis=1)

    #     p_df = data.copy()

    #     df_FTPPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_FTPPatator_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_FTPPatator_benign_logic_model.sav", df_FTPPatator_benign,"FTPPatator",p_df)
        
       
    #     df_SSHPatator_benign = ref.load_feature_importance(data, ids_model_path+"df_SSHPatator_benign.sav")
    #     p_df =  ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_SSHPatator_benign_logic_model.sav", df_SSHPatator_benign,"SSHPatator",p_df)
     
    #     df_DoS_Slowhttptest_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Slowhttptest_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_Slowhttptest_benign_logic_model.sav", df_DoS_Slowhttptest_benign,"DoS_Slowhttptest",p_df)
        
    #     df_DoS_Hulk_benign = ref.load_feature_importance(data, ids_model_path+"df_DoS_Hulk_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_Hulk_benign_logic_model.sav", df_DoS_Hulk_benign,"DoS_Hulk",p_df)
          
    #     df_DoS_GoldenEye_benign= ref.load_feature_importance(data, ids_model_path+"df_DoS_GoldenEye_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DoS_GoldenEye_benign_logic_model.sav", df_DoS_GoldenEye_benign,"DoS_GoldenEye",p_df)
        
    #     df_Heartbleed_benign = ref.load_feature_importance(data, ids_model_path+"df_Heartbleed_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Heartbleed_benign_logic_model.sav", df_Heartbleed_benign,"Heartbleed",p_df)
        
    #     df_Web_Attack_Brute_Force_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Brute_Force_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_Brute_Force_benign_logic_model.sav", df_Web_Attack_Brute_Force_benign,"Web_Attack_Brute_Force",p_df)
        
    #     df_Web_Attack_XSS = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_XSS_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_XSS_benign_logic_model.sav", df_Web_Attack_XSS,"Web_Attack_XSS_benign",p_df)
        
    #     df_Web_Attack_Sql_Injection_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_Sql_Injection_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_Sql_Injection_benign_logic_model.sav", df_Web_Attack_Sql_Injection_benign,"Web_Attack_Sql_Injection",p_df)
        
    #     # df_Infiltration_benign = pickle.load(open(ids_model_path+"IDS"+".sav", 'rb'))
    #     df_Infiltration_benign = ref.load_feature_importance(data, ids_model_path+"df_Infiltration_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Infiltration_benign_logic_model.sav", df_Infiltration_benign,"Infiltration",p_df)
        
    #     df_Bot_benign = ref.load_feature_importance(data, ids_model_path+"df_Bot_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Bot_benign_logic_model.sav", df_Bot_benign,"Bot",p_df)
        
    #     df_PortScan_benign = ref.load_feature_importance(data, ids_model_path+"df_PortScan_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_PortScan_benign_logic_model.sav", df_PortScan_benign,"PortScan",p_df)
        
    #     df_DDoS_benign = ref.load_feature_importance(data, ids_model_path+"df_DDoS_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_DDoS_benign_logic_model.sav", df_DDoS_benign,"df_DDoS_benign",p_df)
        
    #     df_Web_Attack_benign = ref.load_feature_importance(data, ids_model_path+"df_Web_Attack_benign.sav")
    #     p_df = ref.predict_ids_attack(data, ids_model_path+"IDS"+"df_Web_Attack_benign_logic_model.sav", df_Web_Attack_benign,"df_Web_Attack",p_df)
       
       
    #     # p_df.to_csv(ids_predicted_csv_path+"sample.csv")
    #     file_name =ref.fileNameFormat("ids")
    #     csv_file_path = f'{ids_predicted_csv_path}/{file_name}.csv'
    #     p_df.to_csv(csv_file_path,index=False,header=True)

    #     import json
    #     json_data = ref.convertCsvToJson(csv_file_path)


    #     json_object = json.dumps(json_data, indent = 4)
    #     file_name =ref.fileNameFormat("ids")
    #     json_file_path = f'{ids_predicted_json_path}/{file_name}.json'
    #     with open( json_file_path, "w") as outfile:
    #         outfile.write(json_object)

    #     print(data)
    #     print(p_df)

    #     return Response ({
    #                 "csv_path":csv_file_path,
    #                 "json_path":json_file_path
    #             })



