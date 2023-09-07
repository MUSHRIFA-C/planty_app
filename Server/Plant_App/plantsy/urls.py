from django.urls import path
from . import views

urlpatterns = [
     path('AddProductView',views.AddProductAPIView.as_view(),name='AddProductView'),
     path('Get_All_productAPIView',views.Get_All_productAPIView.as_view(), name ='Get_All_productAPIView'),
     path('Get_single_productAPIView/<int:id>',views.Get_single_productAPIView.as_view(), name='Get_single_productAPIView'),
     path('Delete_productAPIView/<int:id>',views.Delete_productAPIView.as_view(), name='Delete_productAPIView'),
     path('Update_productAPIView/<int:id>',views.Update_productAPIView.as_view(), name='Update_productAPIView'),
     path('UserRegisterAPIView',views.UserRegisterAPIView.as_view(), name='UserRegisterAPIView'),
     path('LoginAPIView',views.LoginAPIView.as_view(), name='LoginAPIView'),

     path("ViewCategoryAPIView",views.ViewCategoryAPIView.as_view(),name='ViewCategoryAPIView'),
     # path("ViewPlantSingleCategoryAPIView/<int:id>",views.ViewPlantSingleCategoryAPIView.as_view(),name='ViewPlantSingleCategoryAPIView'),

     path("viewuserProfile/<int:id>",views.viewuserProfile.as_view(),name="viewuserProfile"),
     path("updateuserProfile/<int:id>",views.updateuserProfile.as_view(),name="updateuserProfile"),

     




   
]
