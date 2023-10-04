from django.shortcuts import render
from django.conf import settings
from plantsy.serializers import productserializer,registerserializer,loginserializer,ViewCategorySerializer,AddtoCartSerializer
from plantsy.models import product,register,login,Categories,Cart
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView


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
                    name = i['fullname']
                    print(u_id)

            return Response({
                'data':{
                    'login_id':id,
                    'email': email1,
                    'role': role,
                    'password': password
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
            
            return Response({'message': 'updated data successfully', 'success':True}, status= status.HTTP_200_OK)
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
                # p_status=i['petstatus']
                ctgry=i['category']
                name=i['name']
                print(ctgry)
                price=int(prices)
                print(price)
                total_price=price*quantity
                print(total_price)
                tp=str(total_price)

            producto = product.objects.get(id=item)
            product_image = producto.image
            print(image)
                

            serializer = self.serializer_class(data= {'user':user,'item':item,'quantity':quantity,'total_price':tp,'cart_status':cart_status,'category':ctgry,'image':product_image,'itemname':name})
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



        


