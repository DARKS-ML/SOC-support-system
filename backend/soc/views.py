from traceback import print_tb
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,viewsets
from .serializers import MultiLineAuthLogSerializer
from .processing import DataProcessing
import joblib
import pandas as pd

import glob
import os
import time

modulePath = os.path.dirname(__file__)

# Create your views here.

# @desc -> predict single log line 
class SingleLineAuthenticationLogView(APIView):      
    def post(self, request):
        def __init__(self):
            path =modulePath+"/mlmodels/auth_system/"
            self.aaa =  joblib.load(path + "auth_vectorizer_model.joblib")


        input_log = request.data
        ref = DataProcessing()
        data1 = ref.authParserLine(input_log)
        df1 = ref.convertToDataFrame(data1)
        df1_clean = ref.clean(df1, "event")
        stopwords1 = ['pam_unixcronsession' 'by', 'string', 'from',
                      'bye', 'for', 'port', 'sshd', 'ssh', 'root', 'preauth']
        df1_clean = ref.remStopWord(df1_clean, "event", stopwords1)
        path =modulePath+"/mlmodels/auth_system/"

        # model time
        path =modulePath+"/mlmodels/auth_system/"
        loaded_vectorizer = joblib.load(path + "auth_vectorizer_model.joblib")
        
        
        vector_op1 = loaded_vectorizer.transform(df1_clean['event'])
        loaded_pca = joblib.load(path + "auth_pca_model.joblib")
        pca_data1 = loaded_pca.transform(vector_op1.todense())

        loaded_model_kmeans =  joblib.load(path + "auth_kmeans_model.joblib")
        model_data1 = loaded_model_kmeans.predict(pca_data1)

        loaded_model2 = joblib.load(path + 'auth_sgd_model.joblib')
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
        dir_name = '/home/iamdpk/Project Work/SOC-support-system/Dataset/'
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
        if 'path' not in request.GET:
            return Response({"msg":"please enter a valid parameter"})

        file_path = self.request.query_params.get('path')
        if file_path.endswith(".log"):
            ref = DataProcessing()
            try:
                log_file  = ref.autLogFileParser(file_path)
                df = pd.DataFrame(log_file)
                df_copy = df.copy()
                df_clean = ref.clean(df,"event")
                stopwords = ['pam_unixcronsession','' 'by', 'string', 'from', 'bye', 'for', 'port', 'sshd', 'ssh', 'root', 'preauth']
                df_clean = ref.remStopWord(df_clean, "event", stopwords)
                path = '/home/iamdpk/Project Work/SOC-support-system/backend/soc/mlmodels/auth_system/'
                vector_op, vectorizer = ref.authVectorizer(path, df_clean['event'])
                pca_data, pca = ref.pca(path, vector_op.todense())
            except:
                return Response({
            "error":"Please choose a valid file"
        })

            return Response({"msg":log_file}) 
        
        
        elif file_path.endswith(".csv"):
            return Response({"msg":"process csv"}) 


        return Response({
            "error":"Please choose a valid file"
        })
    

    