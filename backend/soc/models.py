from cProfile import label
from pyexpat import model
from urllib import request
from django.db import models

# Create your models here.
class AuthenticationLogModel(models.Model):
    request = models.TextField()
    label = models.CharField(max_length=20)