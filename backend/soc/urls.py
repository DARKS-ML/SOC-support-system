from django.urls import  path
from .views import SingleLineAuthenticationLogView,MultiLineAuthLogView,AuthLogFileDetailsView,PredictedAuthFileDetailsView

urlpatterns = [
    path("singlelinepredict/",SingleLineAuthenticationLogView.as_view(),name="singlelinepredict"),
    path("dataset/",AuthLogFileDetailsView.as_view(),name="dataset"),
    path("previous/",PredictedAuthFileDetailsView.as_view(),name="previous_result"),
    path("predict/",MultiLineAuthLogView.as_view(),name="predict"),
]
