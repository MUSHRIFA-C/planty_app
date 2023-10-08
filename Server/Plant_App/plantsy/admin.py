from django.contrib import admin
from .models import product,login,register,Cart,OrderAddress,Order,payment,Favorite

# Register your models here.

admin.site.register(product)
admin.site.register(login)
admin.site.register(register)
admin.site.register(Cart)
admin.site.register(OrderAddress)
admin.site.register(Order)
admin.site.register(payment)
admin.site.register(Favorite)


