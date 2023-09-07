from django.contrib import admin
from .models import product,login,register

# Register your models here.

admin.site.register(product)
admin.site.register(login)
admin.site.register(register)

