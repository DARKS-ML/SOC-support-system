import os

from django import views
from rest_framework import serializers


class AuthenticationLogSerializer(serializers.Serializer):
     """Predicated data serializer."""
     log_request = serializers.CharField(max_length = 200)
     label = serializers.CharField(max_length = 20)




class MultiLineAuthLogSerializer(serializers.Serializer):
   """field for serialozer"""
   path = serializers.CharField(max_length=400)