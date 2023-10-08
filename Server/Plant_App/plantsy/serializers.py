from rest_framework import serializers

from .models import product,register,login,Categories,Cart,OrderAddress,payment,Order,Favorite

class productserializer(serializers.ModelSerializer):
    class Meta:
        model = product
        fields = '__all__'
    def create(self,validated_data):
        return product.objects.create(**validated_data)

class registerserializer(serializers.ModelSerializer):
    class Meta:
        model = register
        fields = '__all__'
    def create(self,validated_data):
        return register.objects.create(**validated_data)

class loginserializer(serializers.ModelSerializer):
    class Meta:
        model = login
        fields = '__all__'
    def create(self,validated_data):
        return login.objects.create(**validated_data)

class ViewCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Categories
        fields = '__all__'
        def create(self,validated_data):
            return Categories.objects.create(**validated_data)

class AddtoCartSerializer(serializers.ModelSerializer):
    class Meta:
        model=Cart
        fields='__all__' 
        def create(self,validated_data):
            return Cart.objects.create(**validated_data)

class OrderAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model=OrderAddress
        fields='__all__' 
        def create(self,validated_data):
            return OrderAddress.objects.create(**validated_data)

class PlaceOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model=Order
        fields='__all__'
        def create(self,validated_data):
            return Order.objects.create(**validated_data)

class FavoriteItemSerializer(serializers.ModelSerializer):
    class Meta:
        model=Favorite
        fields='__all__' 
        def create(self,validated_data):
            return Favorite.objects.create(**validated_data)
        
class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = payment
        fields = '__all__'
    def Create(self, validated_data):
        return payment.objects.Create(**validated_data)

