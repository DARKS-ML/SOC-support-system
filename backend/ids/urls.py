from django.urls import  path
from .views import IDSLogView,IDSLogFileDetailsView

urlpatterns = [
    path("dataset/",IDSLogFileDetailsView.as_view(),name="dataset"),
    path("predict/",IDSLogView.as_view(),name="predict"),

]
