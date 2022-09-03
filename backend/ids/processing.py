
from xmlrpc.client import ResponseError
import pandas as pd
import os
import csv 
import numpy as np
from sklearn.preprocessing import LabelEncoder
# import plotly.graph_objects as go
# import matplotlib.pyplot as plt
# import seaborn as sns
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.linear_model import SGDClassifier
from sklearn.linear_model import LogisticRegression
from rest_framework.response import Response
from rest_framework import status
import xgboost as xgb

import  pickle

from pytz import timezone 
from datetime import datetime



class IDSLogDataProcessing:

    def getCurrentDateTime(self):
        currentdatetime = datetime.now(timezone("Asia/kathmandu")).strftime('%Y-%m-%d %H:%M:%S.%f')
        return currentdatetime

    def fileNameFormat(self,file_type):
        current_time = datetime.now(timezone("Asia/kathmandu")).strftime('%Y_%m_%d')
        file_name = file_type+"_"+current_time
        return file_name

    def convertCsvToJson(self,csv_file):
        json_data = []
        with open(csv_file) as f:
            records = csv.DictReader(f)
            for row in records:
                json_data.append(row)
        return json_data

    def saveJsonFile(self,file_path,json_data,json_file_name):
        import json
        # Serializing json 
        json_object = json.dumps(json_data, indent = 4)
        # Writing to sample.json
        with open(json_file_name+".json", "w") as outfile:
            outfile.write(json_object)

    def dfAppendClean(self,csv_files):
        try:
            data =  pd.read_csv(csv_files)
            column_to_remove = ['Flow ID', 'Source IP', 'Source Port', 'Destination IP','Protocol', 'Timestamp']
            if set(column_to_remove).issubset(data.columns):
                data = data.drop(column_to_remove, axis=1)

            column_to_remove = ['Flow ID', ' Source IP', ' Source Port', ' Destination IP',' Protocol', ' Timestamp']
            if set(column_to_remove).issubset(data.columns):
                data = data.drop(column_to_remove, axis=1)
            # data = pd.DataFrame()
            data = data.fillna(0)
            # data[' Label'] = data[' Label'].str.replace(r'[^\w\s]+', '')
            data = data.replace([np.inf, -np.inf], 0) 
            if ' Label' in data.columns:
                data = data.drop(' Label',axis=1)  

            if 'Label' in data.columns:
                data = data.drop(' Label',axis=1)  

            return data
        except Exception as e:
            return Response({
                "error":e   
            },
             status=status.HTTP_400_BAD_REQUEST
            )

    def timeIpPort(self,csv_files):
        data = pd.read_csv(csv_files)
        columns_name =[' Source IP',' Destination IP',' Protocol', ' Timestamp']
        data = data[columns_name]
        return data

    
    def combineDf(self,df1, df2, ifraction):
        n = int(((1-ifraction)/ifraction)*len(df1))
        df3 = df2.sample(n=n)
        df4 = df3.append(df1)
        return df4.sample(frac=1)
    
    def load_feature_importance(self,df,model_name):
        load_model = pickle.load(open(model_name, 'rb'))
        imp = load_model.feature_importances_
        names = df.columns
        
        feature_imp = np.array(imp)
        feature_names = np.array(names)
        data1 = {'feature_names':feature_names, 'feature_importance':feature_imp}

        fi_df = pd.DataFrame(data1)
        fi_df.sort_values(by=['feature_importance'], ascending=False, inplace=True)
        df_i = fi_df.head(10)
        df1 = df[df_i.feature_names]
        return df1


    def predict_ids_attack(self,model_name,loaded_feature,column_name,csf_file):
        updated_df = pd.DataFrame()
        updated_df= loaded_feature.copy()
        prob_column_name = column_name+"_prob"

        # logic model
        try:
            predicted_result_logic = pickle.load(open(model_name+"logic_model.sav", 'rb'))
            pred_logic = predicted_result_logic.predict(loaded_feature)
            pred_prob_logic = predicted_result_logic.predict_proba(loaded_feature)

            updated_df[column_name+"_logic"]=pred_logic
            x,y = zip(*pred_prob_logic.tolist())
            updated_df[prob_column_name+"_logic"]=y
        except Exception as e:
            print(e)


        # newral network
        try:
            predicted_result_nn = pickle.load(open(model_name+"nn_model.sav", 'rb'))
            pred_nn = predicted_result_nn.predict(loaded_feature)
            pred_prob_nn = predicted_result_nn.predict_proba(loaded_feature)

            updated_df[column_name+"_nn"]=pred_nn
            x,y = zip(*pred_prob_nn.tolist())
            updated_df[prob_column_name+"_nn"]=y
        except Exception as e:
            print(e)
        
        
        # # sgd network
        try:
            predicted_result_sgd = pickle.load(open(model_name+"sgd_model.sav", 'rb'))
            pred_sgd = predicted_result_sgd.predict(loaded_feature)
            # pred_prob_sgd = predicted_result_sgd.predict_proba(loaded_feature)

            updated_df[column_name+"_sgd"]=pred_sgd
            # updated_df[prob_column_name+"_sgd"]=pred_prob_sgd.tolist()
        except Exception as e:
            print(e)


         # xgb network
        try:
            predicted_result_xgb = pickle.load(open(model_name+"xgb_model.sav", 'rb'))
            pred_xgb = predicted_result_xgb.predict(loaded_feature)
            pred_prob_xgb = predicted_result_xgb.predict_proba(loaded_feature)

            updated_df[column_name+"_xgb"]=pred_xgb
            x,y = zip(*pred_prob_xgb.tolist())
            updated_df[prob_column_name+"_xgb"]=y

        except Exception as e:
            print(e) 



        new_df = pd.DataFrame()
        new_df =self.timeIpPort(csf_file)

        # [' Source IP',' Destination IP',' Protocol', ' Timestamp']
        updated_df[['Source IP','Destination IP','Protocol', 'Timestamp']] =new_df[[' Source IP',' Destination IP',' Protocol', ' Timestamp']]

        return updated_df


    # def createDirectoryAndFileAsPerModelName(self,p_df,directory_name,ids_predicted_csv_path,ids_predicted_json_path,):

    def createModelCsvJsonFolder(self,daywisefolderPath,model_name,p_df,daywisefolderName):
        import shutil
        modelFolderPath =  os.path.join(daywisefolderPath, model_name)
        if os.path.exists(modelFolderPath):
            shutil.rmtree(modelFolderPath)
        os.mkdir(modelFolderPath)
        csv_f = "csv"
        csv_path = os.path.join(modelFolderPath,csv_f)
        if os.path.exists(csv_path):
            shutil.rmtree(csv_path)
        os.mkdir(csv_path)
        # file_name =self.fileNameFormat(model_name)
        file_name =model_name+"_"+daywisefolderName
        csv_file_path = f'{csv_path}/{file_name}.csv'
        p_df.to_csv(csv_file_path,index=False,header=True)

        json_f = "json"
        json_path = os.path.join(modelFolderPath,json_f)
        if os.path.exists(json_path):
            shutil.rmtree(json_path)
        os.mkdir(json_path)

        import json
        json_data = self.convertCsvToJson(csv_file_path)
        json_object = json.dumps(json_data, indent = 4)
        json_file_path = f'{json_path}/{file_name}.json'
        with open( json_file_path, "w") as outfile:
            outfile.write(json_object)



    def createDirectoryAndFileAsPerModelName(self,ids_predicted_base_path,model_name,p_df):
        file_name =self.fileNameFormat(model_name)
        import os
        import shutil
        parent_dir = ids_predicted_base_path 

        directory_name = self.fileNameFormat(model_name)
        base_path =  os.path.join(parent_dir, directory_name)
        if os.path.exists(base_path):
            shutil.rmtree(base_path)
        os.mkdir(base_path)

        csv_f = "csv"
        csv_path = os.path.join(base_path,csv_f)
        if os.path.exists(csv_path):
                shutil.rmtree(csv_path)
        os.mkdir(csv_path)

        csv_file_path = f'{csv_path}/{file_name}.csv'
        p_df.to_csv(csv_file_path,index=False,header=True)

        import json
        json_data = self.convertCsvToJson(csv_file_path)


        json_object = json.dumps(json_data, indent = 4)

        json_f = "json"
        json_path = os.path.join(base_path,json_f)
        if os.path.exists(json_path):
                shutil.rmtree(json_path)
        os.mkdir(json_path)

        json_file_path = f'{json_path}/{file_name}.json'
        with open( json_file_path, "w") as outfile:
            outfile.write(json_object)