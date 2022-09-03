from django.shortcuts import render
from django.conf import settings
import jwt
import os


from rest_framework import generics,status
from rest_framework.response import Response
# from rest_framework import permissions

from rest_framework_simplejwt.tokens import RefreshToken


from .serializers import RegisterSerializer,LoginSerializer
from .models import User



class RegisterView(generics.GenericAPIView):
    serializer_class = RegisterSerializer
    # permission_classes = [permissions.AllowAny]
    def post(self,request):
        user = request.data
        serializer = self.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        user_data = serializer.data
        return Response(user_data, status=status.HTTP_201_CREATED)


class LoginAPIView(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        # print(f"data is ${data}")
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

