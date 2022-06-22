from django import views
from rest_framework import serializers


class AuthenticationLogSerializer(serializers.Serializer):
     """Predicated data serializer."""
     label = serializers.CharField(max_length = 20)
