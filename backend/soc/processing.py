import re
import csv 

import pandas as pd
import numpy as np


import nltk
from nltk.corpus import stopwords

from pytz import timezone 
from datetime import datetime

from sklearn.decomposition import PCA
from scipy.spatial import distance

class AuthLogDataProcessing:
    """class which pre preocess input data and then load, predict through model"""
    def getCurrentDateTime(self):
        currentdatetime = datetime.now(timezone("Asia/kathmandu")).strftime('%Y-%m-%d %H:%M:%S.%f')
        return currentdatetime

    def fileNameFormat(self,file_type):
        current_time = datetime.now(timezone("Asia/kathmandu")).strftime('%Y_%m_%d__%H_%M_%S')
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
    
    def autLogFileParser(self,log_file):
        file_name = log_file
        file = open(file_name, "r")
        data = []
        order = ["date", "time", "ip", "process", "event"]
        
        for line in file.readlines():
            split1 = re.split(":", line, 3)
            event = split1[3]
            date = re.findall("^\S+\s+[0-9]{2}", line)
            time = re.findall("([0-9]{2}\\:[0-9]{2}\\:[0-9]{2})", line)[0]
            ip = re.findall("([a-z]{2}\\-[0-9]*\\-[0-9]*\\-[0-9]*\\-[0-9]*)", line)[0]
            process = re.findall("([a-zA-Z]*\\[[0-9]*\\])", line)[0]
            details = [date, time, ip, process, event]
            structure = {key:value for key, value in zip(order, details)}
            data.append(structure)
        return data

    def authParserLine(self,line):
        """take input line and then parse it"""
        order = ["date", "time", "ip", "process", "event"]
        
        split1 = re.split(":", line, 3)
        event = split1[3]
        date = re.findall("^\S+\s+[0-9]{2}", line)
        time = re.findall("([0-9]{2}\\:[0-9]{2}\\:[0-9]{2})", line)[0]
        ip = re.findall("([a-z]{2}\\-[0-9]*\\-[0-9]*\\-[0-9]*\\-[0-9]*)", line)[0]
        process = re.findall("([a-zA-Z]*\\[[0-9]*\\])", line)[0]
        details = [date, time, ip, process, event]
        structure = {key:value for key, value in zip(order, details)}
        
        return structure

    def convertToDataFrame(self,input_data):
        return pd.DataFrame(input_data)

    def clean(self,dataframe, column_name):
        dataframe[column_name] = dataframe[column_name].str.lower()
        # Remove numbers and special-characters from Event
        dataframe[column_name] = dataframe[column_name].str.replace('\d+', '')
        dataframe[column_name] = dataframe[column_name].str.replace(r'[^\w\s]+', '')
        # remove after 'user' including user :(
        dataframe[column_name] = dataframe[column_name].apply(lambda x: x.split(' user ')[0])
        return dataframe

    def remStopWord(self,dataframe, column_name, s_words):
        import nltk
        from nltk.corpus import stopwords
        nltk.download('stopwords')
        all_stopwords = stopwords.words('english')
        all_stopwords.extend(s_words)
        dataframe[column_name] = dataframe[column_name].apply(lambda x: ' '.join([word for word in x.split() if word not in (all_stopwords)]))
        return dataframe
    
    # model loading 
    def loadModel(self,path, mod_name):
        return pickle.load(open(path + 'auth_'+mod_name+'.sav', 'rb'))


    def pca(self,path, input_data):
        pca = PCA(n_components=0.95) 
        pca.fit(input_data)
        data = pca.transform(input_data)
        pickle.dump(pca, open(path + 'auth_pca_model.sav', 'wb'))
        #   joblib.dump(pca, path + "auth_pca_model.joblib", compress=True)
        
        return data, pca

    def fromCentDistance(self,pca_data, model):
        centroids = model.cluster_centers_
        df_cent = pd.DataFrame(centroids)
        df_cent['label'] = [i for i in range(len(centroids))]
        df_pca_data = pd.DataFrame(pca_data)
        df_pca_data['label'] = model.predict(pca_data)
        df_pca_data_join = df_pca_data.join(df_cent, 
                                            on='label', 
                                            how='left', 
                                            lsuffix='_pca',
                                            rsuffix='_cent')
        df_pca_1 = df_pca_data_join.loc[:, "0_pca":"label_pca"]
        df_pca_1.drop('label_pca', axis=1, inplace=True)
        df_cent_1 = df_pca_data_join.loc[:, "0_cent":"label_cent"]
        df_cent_1.drop('label_cent', axis=1, inplace=True)
        list1 = df_pca_1.to_numpy().tolist()
        list2 = df_cent_1.to_numpy().tolist()
        distances = []
        for i in range(len(list1)):
            dist = distance.euclidean(list1[i],list2[i])
            distances.append(dist)
        
        return distances
   
    def modified_zscore(self,distance, consistency_correction=1.4826):
        
        median = np.median(distance)
        
        deviation_from_med = np.array(distance) - median
        
        mad = np.mean(np.abs(deviation_from_med))
        mod_zscore = deviation_from_med/(consistency_correction*mad)
        
        return mod_zscore, mad