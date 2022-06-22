from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import AuthenticationLogSerializer
from .processing import DataProcessing
import joblib

import os
modulePath = os.path.dirname(__file__)

# Create your views here.


class AuthenticationLogView(APIView):      
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
