from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response

from .serializers import AuthenticationLogSerializer

# Create your views here.
class AuthenticationLogView(APIView):

    
    def get(self,request):
        data= {"label": "Normal"}
        results = AuthenticationLogSerializer(data).data
        return Response(results)
        