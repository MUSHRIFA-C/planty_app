from django.shortcuts import render
from plantsy.serializers import productserializer,registererializer,loginserializer,ViewCategorySerializer
from plantsy.models import product,register,login,Categories
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView

# Create your views here.

class UserRegisterAPIView(GenericAPIView):
    serializer_class = registererializer
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
        
# # class ViewPlantSingleCategoryAPIView(GenericAPIView):
#     serializer_class=ViewPlantSerializer
#     def get(self,request,id):
#         queryset=Categories.objects.all().filter(pk=id).values()
#         for i in queryset:
#             c_id=i['id']
#             print(c_id)
#         data = PetData.objects.filter(categoryId=c_id).values()
#         serializer_data=list(data)
#         print(serializer_data)
#         for obj in serializer_data:
#             obj['image']=settings.MEDIA_URL + str(obj['image'])
            
#         return Response({'data':serializer_data,'message':'Single Category data','success':True},status=status.HTTP_200_OK)
# 

# class ViewAllCategoryItemAPIView(GenericAPIView):
#     serializer_class=ViewPlantSerializer
#     def get(self,request):
#         queryset=PetData.objects.all()
#         if(queryset.count()>0):
#             serializer=ViewPlantSerializer(queryset,many=True)
#             return Response({'data':serializer.data,'message':'all Categories Items','success':True},status=status.HTTP_200_OK)
#         else:
#             return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)


        #view all users

class Get_All_productAPIView(GenericAPIView):
    serializer_class = productserializer
    def get(self,request):
        queryset = product.objects.all()
        if(queryset.count()>0):
            serializer = productserializer(queryset,many = True)

            return Response({'data': serializer.data,'message': 'all product data set', 'success': True}, status = status.HTTP_200_OK)
        else:
            return Response({'data': 'non data available', 'success': False}, status = status.HTTP_201_CREATED)


        #view single user

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


class viewuserProfile(GenericAPIView):
    def get(self,request,id):
        queryset=register.objects.get(pk=id)
        serializer=registererializer(queryset)
        return Response({'data':serializer.data,'message':'Single user data','success':True},status=status.HTTP_200_OK)
    
class updateuserProfile(GenericAPIView):
    serializer_class = registererializer
    def put(self,request,id):
        queryset=register.objects.get(pk=id)
        print(queryset)
        serializer=registererializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)        




        


