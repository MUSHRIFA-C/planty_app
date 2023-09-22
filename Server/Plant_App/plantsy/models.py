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
    log_id=models.OneToOneField(login,on_delete=models.CASCADE)
    
    def __str__(self):
        return self.fullname

