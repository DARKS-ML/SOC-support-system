from django.urls import  path
from .views import IDSLogView,IDSLogFileDetailsView,MultiClassPrediction,ListAllPredictedModelResult,GroupBy

urlpatterns = [
    path("dataset/",IDSLogFileDetailsView.as_view(),name="dataset"),
    # path("previous/",PredictedIDSFileDetailsView.as_view(),name="previous"),
    path("previous/",ListAllPredictedModelResult.as_view(),name="previous"),
    path("predict/",IDSLogView.as_view(),name="predict"),
    path("multiclass/",MultiClassPrediction.as_view(),name="multiclass"),
    path("groupby/",GroupBy.as_view(),name="groupby"),
    

]
