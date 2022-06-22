from django.urls import  path
from .views import AuthenticationLogView

urlpatterns = [
    path("authpredict/",AuthenticationLogView.as_view(),name="auth_log"),
]
