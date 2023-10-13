from django.shortcuts import render
from django.conf import settings
from plantsy.serializers import productserializer,registerserializer,loginserializer,ViewCategorySerializer,AddtoCartSerializer,OrderAddressSerializer,PlaceOrderSerializer,PaymentSerializer,FavoriteItemSerializer
from plantsy.models import product,register,login,Categories,Cart,OrderAddress,Order,Favorite
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from django.db.models import Sum

from rest_framework import generics
from rest_framework import filters
from django.db.models import Q


         # Create your views here.

class UserRegisterAPIView(GenericAPIView):
    serializer_class = registerserializer
    serializer_class_login = loginserializer
    def post(self, request):

        login_id =''
        fullname = request.data.get('fullname')
        email1 = request.data.get('email')
        phonenumber = request.data.get('phonenumber')
        password = request.data.get('password')
        role = request.data.get('role')
        userstatus='0'

        if(login.objects.filter(email=email1)):
            return Response({'message': 'Duplicate Username Found'},status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data ={'email': email1, 'password': password, 'role': role})

        if serializer_login.is_valid():
            Log = serializer_login.save()
            login_id = Log.id
            print(login_id)
        serializer = self.serializer_class(
            data = {
                'log_id':login_id,
                'fullname': fullname,
                'username': email1,
                'email': email1,
                'phonenumber': phonenumber,
                'password': password,
                'role': role,
                'userstatus':userstatus,
            })
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data': serializer.data, 'message': 'Registration Succesful', 'success':True},status = status.HTTP_201_CREATED)
        return Response({'data': serializer.errors, 'message': 'Registration Failed', 'success': False},status = status.HTTP_400_BAD_REQUEST)
        

class LoginAPIView(GenericAPIView):
    serializer_class = loginserializer

    def post(self,request):
        u_id= ''
        email1 = request.data.get('email')
        password = request.data.get('password')
        
        print(email1)
        print(password)
        logreg = login.objects.filter(email=email1, password=password)
        if(logreg.count()>0):
            read_serializer= loginserializer(logreg, many= True)
            for i in read_serializer.data:
                id= i['id']
                print(id)
                role= i['role']
                regdata = register.objects.all().filter(log_id= id).values()
                print(regdata)
                for i in regdata:
                    u_id = i['id']
                    l_status=i['userstatus']
                    name = i['fullname']
                    print(u_id)

            return Response({
                'data':{
                    'login_id':id,
                    'email': email1,
                    'role': role,
                    'password': password,
                    'l_status':l_status,
                    },
                'success': True,
                'message': 'Logged In Successfully'
            }, status = status.HTTP_201_CREATED)
        else:
            return Response({
                    'message': 'username or password is invalid',
                    'success': False
                }, status = status.HTTP_400_BAD_REQUEST)


class ViewAllUserAPIView(GenericAPIView):
    serializer_class=registerserializer
    def get(self,request):
        queryset=register.objects.all()
        if(queryset.count()>0):
            serializer=registerserializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all user ','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)


class AddProductAPIView(GenericAPIView):
    serializer_class = productserializer

    def post(self, request):
        
        plantname = request.data.get('plantname')
        ptprice = request.data.get('ptprice')
        ptdescription = request.data.get('ptdescription')
        ptsize = request.data.get('ptsize')
        pthumidity = request.data.get('pthumidity')
        pttemp= request.data.get('pttemp')
        images = request.data.get('images')
        ptrating = request.data.get('ptrating')
        category = request.data.get('category')
        expdate=request.POST.get('expdate')


        serializer = self.serializer_class(data= {'name': plantname, 'price': ptprice, 'description': ptdescription, 'size': ptsize, 'humidity': pthumidity, 'temparature': pttemp , 'rating': ptrating , 'image': images , 'category': category })
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data': serializer.data, 'message': 'product added successfully', 'success': True}, status = status.HTTP_201_CREATED)
        return Response({'data': serializer.errors, 'message': 'Failed', 'success': False},status.HTTP_400_BAD_REQUEST)

        ###view category###

class ViewCategoryAPIView(GenericAPIView):
    serializer_class=ViewCategorySerializer
    def get(self,request):
        queryset=Categories.objects.all()
        if(queryset.count()>0):
            serializer=ViewCategorySerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all Categories','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        


         #view all product

class Get_All_productAPIView(GenericAPIView):
    serializer_class = productserializer
    def get(self,request):
        queryset = product.objects.all()
        if(queryset.count()>0):
            serializer = productserializer(queryset,many = True)

            return Response({'data': serializer.data,'message': 'all product data set', 'success': True}, status = status.HTTP_200_OK)
        else:
            return Response({'data': 'non data available', 'success': False}, status = status.HTTP_201_CREATED)


         #view single product admin

class Get_single_productAPIView(GenericAPIView):
    def get(self,request,id):
        queryset = product.objects.get(pk=id)
        serializer = productserializer(queryset)
        return Response({'data': serializer.data,'message': 'single user data', 'success':True}, status= status.HTTP_200_OK)


               #delete product

class Delete_productAPIView(GenericAPIView):
    def delete(self,request,id):
        queryset= product.objects.get(pk=id)
        queryset.delete()
        return Response({'message': 'data deleted suucessfully', 'success': True}, status = status.HTTP_200_OK)

        #update product

class Update_productAPIView(GenericAPIView):
    serializer_class = productserializer
    def put(self,request,id):
        
        queryset=product.objects.get(pk=id)
        print(queryset)
        serializer=productserializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            
            return Response({'message': 'updated data successfully', 'success':True,'data':serializer.data,}, status= status.HTTP_200_OK)
        else:
             return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)

        # user profile view,update

class ProfileViewAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=register.objects.get(pk=id)
        serializer=registerserializer(queryset)
        return Response({'data':serializer.data,'message':'Single user data','success':True},status=status.HTTP_200_OK)


class SingleUserUpdateProfileSerializerAPIView(GenericAPIView):
    serializer_class = registerserializer
    def put(self,request,id):
        queryset=register.objects.get(pk=id)
        print(queryset)
        serializer=registerserializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)

       #cart add,dlt,view,increm,decrem

class AddtoCartAPIView(GenericAPIView):
    serializer_class=AddtoCartSerializer
    def post(self, request):
        total_price=""
        image=""
        category=""
        prices=""
        
        user = request.data.get('user')
        item=request.data.get('item')
        print(item)
        quty = request.data.get('quantity')
        quantity=int(quty)
        cart_status="0"
        
        carts = Cart.objects.filter(user=user, item=item)
        if carts.exists():
            return Response({'message':'Item is already in cart','success':False}, status=status.HTTP_400_BAD_REQUEST)

        else:
            data=product.objects.all().filter(id=item).values()
            for i in data:
                print(i)
                prices=i['price']
                ctgry=i['category']
                name=i['name']
                expday=i['expdate']
                print(ctgry)
                price=int(prices)
                print(price)
                total_price=price*quantity
                print(total_price)
                tp=str(total_price)

            producto = product.objects.get(id=item)
            product_image = producto.image
            print(image)
                

            serializer = self.serializer_class(data= {'user':user,'item':item,'quantity':quantity,'total_price':tp,'cart_status':cart_status,'category':ctgry,'image':product_image,'itemname':name,'expday':expday})
            print(serializer)
            if serializer.is_valid():
                print("hi")
                serializer.save()
                return Response({'data':serializer.data,'message':'Item added to cartsuccessfully', 'success':True}, status = status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Invalid','success':False}, status=status.HTTP_400_BAD_REQUEST)


class SingleCartAPIView(GenericAPIView):
    def get(self, request, id):
        u_id=""
        qset =register.objects.all().filter(pk=id).values()
        for i in qset:
            u_id=i['id']

        data = Cart.objects.filter(user=u_id).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])   
        return Response({'data' : serialized_data, 'message':'single product data','success':True},status=status.HTTP_200_OK) 
    

class CartIncrementQuantityAPIView(GenericAPIView):
    def put(self, request, id):
        cart_item = Cart.objects.get(pk=id)

        qnty=cart_item.quantity
        qty=int(qnty)

        cart_item.quantity=qty + 1

        q=cart_item.quantity
        qn=int(q)

        pr=cart_item.item.price
        price=int(pr)

        tp=price*qn
        cart_item.total_price=tp

        cart_item.save()
        serialized_data = AddtoCartSerializer(cart_item,context={'request':request}).data
        # serialized_data['image']=str(serialized_data['image']).split('http://localhost:8000')[1]
        base_url=request.build_absolute_uri('/')[:-1]
        serialized_data['image']=str(serialized_data['image']).replace(base_url,'')
        return Response({'data' : serialized_data, 'message':'cart item quantity updated','success':True},status=status.HTTP_200_OK)


class CartDecrementQuantityAPIView(GenericAPIView):
    def put(self, request, id):
        cart_item = Cart.objects.get(pk=id)

        qny=cart_item.quantity
        qant=int(qny)
        
        if qant > 1:
            qnty=cart_item.quantity
            qty=int(qnty)
            cart_item.quantity=qty - 1

            q=cart_item.quantity
            qn=int(q)

            pr=cart_item.item.price
            price=int(pr)

            tp=price*qn
            cart_item.total_price=tp

            cart_item.save()
            serialized_data = AddtoCartSerializer(cart_item,context={'request':request}).data
            base_url=request.build_absolute_uri('/')[:-1]
            serialized_data['image']=str(serialized_data['image']).replace(base_url,'')

            return Response({'data' : serialized_data, 'message':'cart item quantity updated','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'message':'Quantity cannot be less than 1','success':False},status=status.HTTP_400_BAD_REQUEST)


class Delete_CartAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = Cart.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Cart Item deleted successfully','success':True}, status = status.HTTP_200_OK)


class TotalorderPriceAPIView(GenericAPIView):
     def get(self,request,id):
        carts=Cart.objects.filter(user=id,cart_status=0)
        print(carts)
        tot=carts.aggregate(total=Sum('total_price'))['total']
        Total_prices=str(tot)
        print(tot)
        return Response({'data':{'total_price':Total_prices},'message':'get order price successfully','success':True},status=status.HTTP_201_CREATED)

       #Order:

# class PlaceOrderAPIView(GenericAPIView):
#     serializer_class=PlaceOrderSerializer
#     def post(self,request):
#         user=request.data.get('user')
#         date=request.data.get('date')
#         carts=Cart.objects.filter(user=user,cart_status=0)
#         if not carts.exists():
#             return Response({'message':'No item in cart to place order','success':False},status=status.HTTP_400_BAD_REQUEST)

#         order_data=[]
#         for i in carts:
#             order_data.append({
#                 'user' : user,
#                 'product' : i.item_id,
#                 'product_name' : i.itemname,
#                 'total_price' : i.total_price,
#                 'expday' : i.expday,
#                 'quantity' : i.quantity,
#                 'image' : i.image,
#                 'category' : i.category,
#                 'orderdate' : date,
#                 'order_status' : "0",
#             })
#             print("order data ========== ",order_data)
#             #i.cart_status="1"
#             i.save()
#         carts.delete()
#         serializer = self.serializer_class(data= order_data, many=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response({'data':serializer.data,'message':'Order placed successfully','success':True}, status = status.HTTP_201_CREATED)
#         return Response({'data':serializer.errors,'message':'Invalid','success':False},status=status.HTTP_400_BAD_REQUEST)

class PlaceOrderAPIView(GenericAPIView):
    serializer_class = PlaceOrderSerializer
    serializer_class_payment = PaymentSerializer

    def post(self, request):
        order_id = ''
        user = request.data.get('user')
        date = request.data.get('date')
        orderAddress = request.data.get('orderAddress')
        contactNum = request.data.get('contactNum')
        userName = request.data.get('userName')
        payment_status = "0"
        carts = Cart.objects.filter(user=user)

        if not carts.exists():
            return Response({'message': 'No item in cart to place order', 'success': False}, status=status.HTTP_400_BAD_REQUEST)

        order_data = []
        for cart in carts:  # Iterate through the Cart objects
            itemName = cart.itemname  # Access properties using dot notation
            amount = cart.total_price

            order_data.append({
                'user': user,
                'product': cart.item_id,
                'orderAddress' : orderAddress,
                'contactNum' : contactNum,
                'userName' : userName,
                'product_name': cart.itemname,
                'total_price': cart.total_price,
                'expday': cart.expday,
                'quantity': cart.quantity,
                'image': cart.image,
                'category': cart.category,
                'orderdate': date,
                'order_status': "0",
            })

            cart.cart_status = "1"
            cart.save()

        carts.delete()
        serializer = self.serializer_class(data=order_data, many=True)

        if serializer.is_valid():
            order = serializer.save()
            print(order)
            for i in order:
                order_id = i.id
                print(order_id)

        serializer_order = self.serializer_class_payment(data={
            'order': order_id,
            'user': user,
            'name': itemName,
            'amount': amount,
            'date': date,
            'payment_status': payment_status
        })

        if serializer_order.is_valid():
            serializer_order.save()
            return Response({'data': serializer_order.data, 'message': 'Order placed successfully', 'success': True},
                            status=status.HTTP_201_CREATED)

        return Response({'data': serializer_order.errors, 'message': 'Invalid', 'success': False},
                        status=status.HTTP_400_BAD_REQUEST)


class ViewAllOrdersSerializerAPIView(GenericAPIView):
    def get(self,request):
        queryset=Order.objects.all().values()
        serializer_data=list(queryset)
        for obj in serializer_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])
        return Response({'data':serializer_data,'message':'all order details','success':True},status=status.HTTP_200_OK)

class ViewOrdersSerializerAPIView(GenericAPIView):
    def get(self,request,userId):
        queryset=Order.objects.all().filter(user=userId).values()
        serializer_data=list(queryset)
        for obj in serializer_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])
        return Response({'data':serializer_data,'message':'all order details','success':True},status=status.HTTP_200_OK)


class ViewOrderAddressAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=OrderAddress.objects.all().filter(user=id).values()
        serializer_data=list(queryset)
        return Response({'data':serializer_data,'message':'all Order Address','success':True},status=status.HTTP_200_OK)

class ViewSingleOrderAddressAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=OrderAddress.objects.get(pk=id)
        serializer=OrderAddressSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single Order Address','success':True},status=status.HTTP_200_OK)
    
class UpdateOrderAddressSerializerAPIView(GenericAPIView):
    serializer_class = OrderAddressSerializer
    def put(self,request,id):
        queryset=OrderAddress.objects.get(pk=id)
        print(queryset)
        serializer=OrderAddressSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)


class SaveOrderAddressAPIView(GenericAPIView):
    serializer_class=OrderAddressSerializer
    def post(self,request,id):
        user=request.data.get("user")
        pincode=request.data.get("pincode")
        city=request.data.get("city")
        state=request.data.get("state")
        area=request.data.get("area")
        buildingName=request.data.get("buildingName")
        landmark=request.data.get("landmark")
        addressType=request.data.get("addressType")
        orderAddressStatus="0"

        user_id = register.objects.get(id=user)
        user_id.userstatus = "1"
        user_id.save()

        data=register.objects.all().filter(id=user).values()
        for i in data :
            name=i['fullname']
            print(name)
            contact=i['phonenumber']
            print(contact)
        serializer=self.serializer_class(data={'user':user,'name':name,'contact':contact,'pincode':pincode,'city':city,'state':state,'area':area,'buildingName':buildingName,'landmark':landmark,'addressType':addressType,'orderAddressStatus':orderAddressStatus})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your address saved Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)

             #payment

# class PaymentSerializerAPIView(GenericAPIView):
#     serializer_class=PaymentSerializer
#     def post(self,request):
#         user=request.data.get('user')
#         date=request.data.get('date')
#         amount=request.data.get('amount')
#         payment_status="0"
#         data=outsiders.objects.all().filter(id=user).values()
#         for i in data:
#             name=i['fullnameController']
#         serializer=self.serializer_class(data={'user':user,'date':date,'amount':amount,'payment_status':payment_status,'name':name})
#         print(serializer)
#         if serializer.is_valid():
#             print('hai')
#             serializer.save()
#             return Response({'data':serializer.data,'message':'Your payment done  Successfully','success':True},status = status.HTTP_201_CREATED)
#         return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)
  

          #favorite:

class FavoriteItemAPIView(GenericAPIView):
    serializer_class=FavoriteItemSerializer
    def post(self, request):
        user = request.data.get('user')
        item=request.data.get('item')
        favStatus="1"
        carts = Favorite.objects.filter(user=user, item=item)
        if carts.exists():
            return Response({'message':'Item is already in Favorite','success':False}, status=status.HTTP_400_BAD_REQUEST)

        else:
            data=product.objects.all().filter(id=item).values()
            for i in data:
                prices=i['price']
                name=i['name']

            producto = product.objects.get(id=item)
            product_image = producto.image

            serializer = self.serializer_class(data= {'user':user,'item':item,'item_name':name,'image':product_image,'price':prices,'favStatus':favStatus})
            print(serializer)
            if serializer.is_valid():
                print("hi")
                serializer.save()
                return Response({'data':serializer.data,'message':'Item added to Favorite successfully', 'success':True}, status = status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Invalid','success':False}, status=status.HTTP_400_BAD_REQUEST)


class ViewFavoriteItemsAPIView(GenericAPIView):
    def get(self, request, id):

        u_id=""
        qset =register.objects.all().filter(pk=id).values()
        for i in qset:
            u_id=i['id']
            
        data = Favorite.objects.filter(user=u_id).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])   
        return Response({'data' : serialized_data, 'message':'single product data','success':True},status=status.HTTP_200_OK)

class Delete_FavoriteItemAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = Favorite.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Fav Item deleted successfully','success':True}, status = status.HTTP_200_OK)
    

#from django.db.models import Q

class Delete_FavoriteItemInHomePageAPIView(GenericAPIView):
    def delete(self, request, itemId):
        # Use Q objects to create an OR condition
        delmember = Favorite.objects.filter(item=itemId)
        if delmember:
            delmember.delete()
            return Response({'message': 'Fav Item deleted successfully', 'success': True}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'Favorite item not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

                  ##search##

class ItemSearchAPIView(GenericAPIView):
    def post(self, request):
        search = request.data.get('search')
        data = product.objects.filter(Q(name__iexact=search) | Q(name__icontains=search)).values()
        serialized_data = list(data)
        for obj in serialized_data:
            obj['image'] = settings.MEDIA_URL + str(obj['image'])       
        return Response({'data': serialized_data, 'message': 'Search data', 'success': True}, status=status.HTTP_200_OK)
            
            #searchorder
class OrderItemSearchAPIView(GenericAPIView):
    def post(self, request, userId):
        search=request.data.get('search')
        data=Order.objects.filter(product_name=search,user=userId).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image']) 
        return Response({'data':data,'message':'Search data','success':True},status=status.HTTP_200_OK)

class RatingPlantAPIView(GenericAPIView):
    def put(self, request, id):
        try:
            ratings = product.objects.get(pk=id)
        except product.DoesNotExist:
            return Response({'message': 'Plant not found', 'success': False}, status=status.HTTP_404_NOT_FOUND)

        rate = request.data.get('rate')
        if rate is None:
            return Response({'message': 'Rate is not provided', 'success': False}, status=status.HTTP_400_BAD_REQUEST)
        try:
            rate = float(rate)
        except ValueError:
            return Response({'message': 'Invalid rate format', 'success': False}, status=status.HTTP_400_BAD_REQUEST)

        count = ratings.rating_count or 0 
        count += 1  
        ratings.rating_count = count

        print("Count =", count)

        if ratings.rating is None:
            ratings.rating = 0.0
        ratings.rating = (rate + ratings.rating * (count - 1)) / count
        ratings.save()

        serialized_data = productserializer(ratings, context={'request': request}).data
        base_url = request.build_absolute_uri('/')[:-1]
        serialized_data['image'] = str(serialized_data['image']).replace(base_url, '')
        
        return Response({'data': serialized_data, 'message': 'Thank you for your rating', 'success': True}, status=status.HTTP_200_OK)






        


