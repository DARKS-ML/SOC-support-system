
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
        data =  pd.read_csv(csv_files)
        # data = pd.DataFrame()
        data = data.fillna(0)
        # data[' Label'] = data[' Label'].str.replace(r'[^\w\s]+', '')
        data = data.replace([np.inf, -np.inf], 0)        
        return data
    
    def combineDf(self,df1, df2, ifraction):
        n = int(((1-ifraction)/ifraction)*len(df1))
        df3 = df2.sample(n=n)
        df4 = df3.append(df1)
        return df4.sample(frac=1)
    
    # def plot_feature_importance(self,imp, names, threshold):
    #     # convert both imp and names to np array in order
    #     # to have 2 column dataframe
    #     feature_imp = np.array(imp)
    #     feature_names = np.array(names)
    #     #create dataframe using a dictionary
    #     data = {'feature_names':feature_names, 'feature_importance':feature_imp}
    #     fi_df = pd.DataFrame(data)

    #     #sort the df in descending order
    #     fi_df.sort_values(by=['feature_importance'], ascending=False, inplace=True)
    #     df_i = fi_df.loc[fi_df['feature_importance'] > threshold]
    #     #barplot
    #     plt.figure(figsize=(10,10))
    #     sns.barplot(x=df_i['feature_importance'], y=df_i['feature_names'])
    #     plt.title('FEATURE IMPORTANCE')
    #     plt.xlabel('feature importance')
    #     plt.ylabel('feature names')
    #     return df_i

      

    # def trainPlot(self,df, threshold, path, df_name):
    #     rfc_model = RandomForestClassifier(n_estimators=100, max_depth=5)
    #     X = df.drop(columns=['Label'])
    #     y = df['Label']
    #     rfc_model.fit(X,y)
    #     pickle.dump(rfc_model, open(path + str(df_name) +'.sav', 'wb'))
    #     df = plot_feature_importance(rfc_model.feature_importances_,X.columns,threshold)
    #     return df
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


    def predict_ids_attack(self,df,model_name,loaded_feature,column_name,updated_df):
        prob_column_name = column_name+"_prob"
        predicted_result = pickle.load(open(model_name, 'rb'))
        pred = predicted_result.predict(loaded_feature)
        pred_prob = predicted_result.predict_proba(loaded_feature)
        print(pred_prob)
        updated_df[column_name]=pred
        updated_df[prob_column_name]=pred_prob.tolist()
        return updated_df
