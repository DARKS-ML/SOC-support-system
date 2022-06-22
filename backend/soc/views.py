from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .serializers import AuthenticationLogSerializer
from .processing import DataProcessing
import pickle

import os
modulePath = os.path.dirname(__file__) 

# Create your views here.
class AuthenticationLogView(APIView):
    def __init__(self):
        # path_to_artifacts = "../../research/"
        # self.values_fill_missing =  joblib.load(path_to_artifacts + "train_mode.joblib")

        self. loaded_vectorizer = pickle.load(open(modulePath + "/mlmodels/auth_system/auth_vectorizer_model.sav", 'rb'))
        self. loaded_pca = pickle.load(open(modulePath + "/mlmodels/auth_system/auth_vectorizer_model.sav", 'rb'))
        self.loaded_model_kmeans = pickle.load(open(modulePath + "/mlmodels/auth_system/auth_pca_model.sav", 'rb'))
        self.loaded_model2 = pickle.load(open(modulePath + "/mlmodels/auth_system/auth_sgd_model.sav", 'rb'))


    
    def get(self,request):
        data= {"label": "Normal"}
        results = AuthenticationLogSerializer(data).data
        return Response(results)
    
    def post(self, request):
        input_log = request.data
        ref = DataProcessing()
        print(input_log)
        data1 = ref.authParserLine(input_log)
        df1 = ref.convertToDataFrame(data1)
        df1_clean = ref.clean(df1,"event")
        stopwords1 = ['pam_unixcronsession' 'by', 'string', 'from', 'bye', 'for', 'port', 'sshd', 'ssh', 'root', 'preauth']
        df1_clean = ref.remStopWord(df1_clean, "event", stopwords1)

        # model time
        # path = 'mlmodels/auth_system/'
        # loaded_vectorizer = ref.loadModel(path,'vectorizer_model')
        # loaded_vectorizer = pickle.load(open(f'{modulePath}/mlmodels/auth_system/auth_vectorizer_model.sav', 'rb'))
        vector_op1 = self.loaded_vectorizer.transform(df1_clean['event'])

        # loaded_pca = ref.loadModel(path,'pca_model')
        # loaded_pca = pickle.load(open(f'{modulePath}/mlmodels/auth_system/auth_vectorizer_model.sav', 'rb'))
        pca_data1 = self.loaded_pca.transform(vector_op1.todense())

        # loaded_model_kmeans = ref.loadModel(path,'kmeans_model')
        # loaded_model_kmeans = pickle.load(open(f'{modulePath}/mlmodels/auth_system/auth_pca_model.sav', 'rb'))
        model_data1 = self.loaded_model_kmeans.predict(pca_data1)

        # loaded_model2 = ref.loadModel(path,'sgd_model')
        # loaded_model2 = pickle.load(open(f'{modulePath}/mlmodels/auth_system/auth_sgd_model.sav', 'rb'))
        vector_op1_df =  ref.convertToDataFrame(vector_op1.todense())
        model_data2 = self.loaded_model2.predict(vector_op1_df)
        result = model_data2.tolist()[0]


        return Response(request.data)

    