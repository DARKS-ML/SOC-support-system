from lib2to3.pgen2 import token
from django.db import models
from django.contrib.auth.models import (AbstractBaseUser,BaseUserManager,PermissionsMixin)

from rest_framework_simplejwt.tokens import RefreshToken

# User manager class for creating custom user
class UserManager(BaseUserManager):
    # @desc -> creating normal user
    def create_user(self,firstname,lastname,phone,email,password=None):
        if firstname is None:
            raise TypeError("first name must be filled")
        if lastname is None:
            raise TypeError("last name must be filled")
        if phone is None:
            raise TypeError("phone number must be filled")
        if email is None:
            raise TypeError("email must be filled")
        
        user =self.model(firstname=firstname,lastname=lastname,phone=phone,email= self.normalize_email(email))
        user.set_password(password)
        user.save()
        return user

    # @desc -> creating super user
    def create_superuser(self,firstname,lastname,phone,email,password=None):
        if password is None:
            raise TypeError("password must be filled")
        
        user = self.create_user(firstname,lastname,phone,email,password)
        user.is_staff = True
        user.is_superuser= True
        user.save()
        return user

class User(AbstractBaseUser,PermissionsMixin):
    firstname = models.CharField(max_length=30)
    lastname = models.CharField(max_length=30)
    phone = models.CharField(max_length=255,unique=True)
    email = models.EmailField(max_length=255,unique=True,db_index=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # objects = UserManager
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['firstname','lastname','phone']

    objects = UserManager()

    def __str__(self) -> str:
        return self.email
    
    def tokens(self):
        token = RefreshToken.for_user(self)
        return {
            'refresh' : str(token),
            'access' : str(token.access_token),
        }