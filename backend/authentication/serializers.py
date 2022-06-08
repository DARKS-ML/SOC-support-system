from django.contrib import auth

from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed

from .models import User

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(max_length=255,min_length=6,write_only=True)

    class Meta:
        model = User
        fields = ['firstname','lastname','phone','email','password']

    def validate(self, attrs):
        firstname = attrs.get('firstname', '')
        lastname = attrs.get('lastname', '')
        phone = attrs.get('phone', '')
        email = attrs.get('email', '')
        
    def create(self, validated_data):
        return User.objects.create_user(**validated_data)


class LoginSerializer(serializers.ModelSerializer):
    email = serializers.CharField(max_length =255,write_only=True)
    password = serializers.CharField(max_length=68, min_length=6, write_only=True)
    tokens = serializers.SerializerMethodField()

    def get_tokens(self, obj):
        user = User.objects.get()
        return {
            'refresh': user.tokens()['refresh'],
            'access': user.tokens()['access']
        }
        
    class Meta:
        model = User
        fields = ['email', 'password', 'tokens']

    def validate(self, attrs):
        email = attrs.get('email','')
        password = attrs.get('password','')
        user = auth.authenticate(email=email,password=password)
        
        if not user:
            raise AuthenticationFailed('Invalid Credential,try again')
        if not user.is_active:
            raise AuthenticationFailed('Account disabled, contacr admin')
       
        
        
        return {
            # 'email' : user.email,
            'tokens' : user.tokens
        }