from django.urls import  path
from .views import SingleLineAuthenticationLogView,MultiLineAuthLogView,AuthLogFileDetailsView

urlpatterns = [
    path("authpredict/",SingleLineAuthenticationLogView.as_view(),name="auth_log"),
    path("logfiles/",AuthLogFileDetailsView.as_view(),name="logfiles"),
    path("data/",MultiLineAuthLogView.as_view(),name="csv_log"),
]
