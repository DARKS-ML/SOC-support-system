import re
import pandas as pd
import nltk
from nltk.corpus import stopwords
# import pickle
import pickle5 as pickle
from sklearn.decomposition import PCA

class DataProcessing:
    """class which pre preocess input data and then load, predict through model"""
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
        nltk.download('stopwords')
        all_stopwords = stopwords.words('english')
        all_stopwords.extend(s_words)
        dataframe[column_name] = dataframe[column_name].apply(lambda x: ' '.join([word for word in x.split() if word not in (all_stopwords)]))
        return dataframe
    
    # model loading 
    def loadModel(self,path, mod_name):
        return pickle.load(open(path + 'auth_'+mod_name+'.sav', 'rb'))

    def pca(path, input_data):
        pca = PCA(n_components=0.95) 
        pca.fit(input_data)
        data = pca.transform(input_data)
        pickle.dump(pca, open(path + 'auth_pca_model.sav', 'wb'))
        #   joblib.dump(pca, path + "auth_pca_model.joblib", compress=True)
        
        return data, pca