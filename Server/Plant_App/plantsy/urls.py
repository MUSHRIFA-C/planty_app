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

     path("ratingplant/<int:id>",views.RatingPlantAPIView.as_view(),name="ratingplant"),

                 ######## view cart item in a perticular user ############

     path("singlecartitem/<int:id>",views.SingleCartAPIView.as_view(),name="singlecartitem"),
     path("cartincrementqnty/<int:id>",views.CartIncrementQuantityAPIView.as_view(),name="cartincrementqnty"),
     path("cartdecrementqnty/<int:id>",views.CartDecrementQuantityAPIView.as_view(),name="cartdecrementqnty"),
     path("deleteCartItem/<int:id>",views.Delete_CartAPIView.as_view(),name="deleteCartItem"),
     path("allOrderPrice/<int:id>",views.TotalorderPriceAPIView.as_view(),name="allOrderPrice"),

                                ####Order###
     path("placeOrder",views.PlaceOrderAPIView.as_view(),name="placeOrder"), 
     path("viewAllOrders",views.ViewAllOrdersSerializerAPIView.as_view(),name="viewAllOrders"),                     
     path("viewOrders/<int:userId>",views.ViewOrdersSerializerAPIView.as_view(),name="viewOrders"),                     
     path("orderAddressSave/<int:id>",views.SaveOrderAddressAPIView.as_view(),name="orderAddressSave"),
     path("viewOrderAddress/<int:id>",views.ViewOrderAddressAPIView.as_view(),name="viewOrderAddress"),
     path("viewSingleOrderAddress/<int:id>",views.ViewSingleOrderAddressAPIView.as_view(),name="viewSingleOrderAddress"),
     path("updateOrderAddress/<int:id>",views.UpdateOrderAddressSerializerAPIView.as_view(),name="updateOrderAddress"),

                                    # search 
     path('item-search',views.ItemSearchAPIView.as_view(), name='item-search'),
     path("searchOrderItem/<int:userId>",views.OrderItemSearchAPIView.as_view(),name="searchOrderItem"),                        
     
                                ###profile####
     path("viewuserProfile/<int:id>",views.ProfileViewAPIView.as_view(),name="viewuserProfile"),
     path("updateuserProfile/<int:id>",views.SingleUserUpdateProfileSerializerAPIView.as_view(),name="updateuserProfile"),

                               ###Favorite####
     path("favoriteItem",views.FavoriteItemAPIView.as_view(),name="favoriteItem"),
     path("viewFavoriteItem/<int:id>",views.ViewFavoriteItemsAPIView.as_view(),name="viewFavoriteItem"),
     path("deleteFavoriteItem/<int:id>",views.Delete_FavoriteItemAPIView.as_view(),name="deleteFavoriteItem"),
     path("deleteFavoriteItemInHomePage/<int:itemId>",views.Delete_FavoriteItemInHomePageAPIView.as_view(),name=""),

     




   
]
