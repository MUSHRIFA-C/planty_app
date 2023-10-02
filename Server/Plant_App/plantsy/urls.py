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
     path('ViewAllUserAPIView',views.ViewAllUserAPIView.as_view(), name='ViewAllUserAPIView'),
     path("addtocart",views.AddtoCartAPIView.as_view(),name="addtocart"),

     path("ViewCategoryAPIView",views.ViewCategoryAPIView.as_view(),name='ViewCategoryAPIView'),

      ######## view cart item in a perticular user ############
     path("singlecartitem/<int:id>",views.SingleCartAPIView.as_view(),name="singlecartitem"),
     path("cartincrementqnty/<int:id>",views.CartIncrementQuantityAPIView.as_view(),name="cartincrementqnty"),
     path("cartdecrementqnty/<int:id>",views.CartDecrementQuantityAPIView.as_view(),name="cartdecrementqnty"),
     path("deleteCartItem/<int:id>",views.Delete_CartAPIView.as_view(),name="deleteCartItem"),

    
     path("viewuserProfile/<int:id>",views.ProfileViewAPIView.as_view(),name="viewuserProfile"),
     path("updateuserProfile/<int:id>",views.SingleUserUpdateProfileSerializerAPIView.as_view(),name="updateuserProfile"),

     




   
]
