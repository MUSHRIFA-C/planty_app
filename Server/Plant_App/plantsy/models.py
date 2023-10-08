from django.db import models

# Create your models here.

class Categories(models.Model):
    name=models.CharField(max_length=100)
    image=models.ImageField(upload_to='images/',max_length=500)
    status=models.CharField(max_length=100)

    def __str__(self):
        return self.name

class product(models.Model):
    name = models.CharField(max_length =50, null= True)
    price = models.CharField(max_length =50, null= True)
    description = models.CharField(max_length =500, null= True)
    size = models.CharField(max_length =50, null= True)
    humidity = models.CharField(max_length =50, null= True)
    temparature = models.CharField(max_length =50, null= True)
    rating = models.CharField(max_length =50, null= True)
    image = models.ImageField(upload_to = 'images/', null=True)
    category=models.CharField(max_length =50, null= True)
    expdate=models.CharField(max_length=200,default='10')
    
    def __str__(self):
        return self.name

class login(models.Model):
    email = models.EmailField(max_length =50, null= True)
    password = models.CharField(max_length =50, null= True)
    role = models.CharField(max_length =50)
    def __str__(self):
        return self.email

class register(models.Model):
    fullname = models.CharField(max_length =50, null= True)
    username = models.CharField(max_length =50, null= True)
    email = models.EmailField(max_length =50, null= True)
    phonenumber = models.CharField(max_length =50, null= True)
    password = models.CharField(max_length =50, null= True)
    role = models.CharField(max_length =50)
    userstatus=models.CharField(max_length=10)
    log_id=models.OneToOneField(login,on_delete=models.CASCADE)
    
    def __str__(self):
        return self.fullname


class Cart(models.Model):
    item=models.ForeignKey(product,on_delete=models.CASCADE)
    user=models.ForeignKey(register,on_delete=models.CASCADE)
    itemname=models.CharField(max_length=500)
    image = models.ImageField(upload_to='images/')
    quantity = models.CharField(max_length=500)
    total_price=models.CharField(max_length=500)
    category = models.CharField(max_length=100)
    cart_status=models.CharField(max_length=10)
    expday = models.CharField(max_length=100,default='10')

class OrderAddress(models.Model):
    user=models.ForeignKey(register,on_delete=models.CASCADE)
    name=models.CharField(max_length=500)
    contact=models.CharField(max_length=500)
    pincode=models.CharField(max_length=500)
    city=models.CharField(max_length=500)
    state=models.CharField(max_length=500)
    area=models.CharField(max_length=500)
    buildingName=models.CharField(max_length=500)
    landmark=models.CharField(max_length=500,null=True,default='No value',blank=True)
    addressType=models.CharField(max_length=500)
    orderAddressStatus=models.CharField(max_length=10)

class Order(models.Model):
    user = models.ForeignKey(register, on_delete=models.CASCADE)
    product = models.ForeignKey(product, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=500,blank=True, null=True)
    orderAddress = models.CharField(max_length=1000)
    contactNum = models.CharField(max_length=200)
    userName = models.CharField(max_length=200)
    product_name = models.CharField(max_length=500,blank=True, null=True)
    orderdate = models.CharField(max_length=100)
    quantity = models.CharField(max_length=500,blank=True, null=True)
    total_price = models.IntegerField()
    image = models.ImageField(upload_to='images/',blank=True, null=True)
    category = models.CharField(max_length=500,blank=True, null=True)
    expday = models.CharField(max_length=100,default='10')
    order_status = models.CharField(max_length=500,blank=True, null=True)

class Favorite(models.Model):
    item=models.ForeignKey(product,on_delete=models.CASCADE,null=True,blank=True)
    user=models.ForeignKey(register,on_delete=models.CASCADE)
    item_name=models.CharField(max_length=500)
    image=models.ImageField(upload_to='images/')
    price=models.CharField(max_length=300)
    favStatus=models.CharField(max_length=200)
    def __str__(self):
        return self.item_name

class payment(models.Model):
    user = models.ForeignKey(register, on_delete=models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    name = models.CharField(max_length=20)
    amount = models.CharField(max_length=20)
    date = models.CharField(max_length=20)
    payment_status = models.CharField(max_length=20)
    def __str__(self):
        return self.amount


