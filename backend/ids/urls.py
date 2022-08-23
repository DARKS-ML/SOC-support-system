from django.urls import  path
from .views import IDSLogView,IDSLogFileDetailsView,PredictedIDSFileDetailsView

urlpatterns = [
    path("dataset/",IDSLogFileDetailsView.as_view(),name="dataset"),
    path("previous/",PredictedIDSFileDetailsView.as_view(),name="previous"),
    path("predict/",IDSLogView.as_view(),name="predict"),

]
