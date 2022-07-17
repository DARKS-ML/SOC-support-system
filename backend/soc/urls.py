from django.urls import  path
from .views import SingleLineAuthenticationLogView,MultiLineAuthLogView,AuthLogFileDetailsView

urlpatterns = [
    path("singlelinepredict/",SingleLineAuthenticationLogView.as_view(),name="singlelinepredict"),
    path("dataset/",AuthLogFileDetailsView.as_view(),name="dataset"),
    path("predict/",MultiLineAuthLogView.as_view(),name="predict"),
]
