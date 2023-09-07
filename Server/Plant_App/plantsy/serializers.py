from rest_framework import serializers

from .models import product,register,login,Categories

class productserializer(serializers.ModelSerializer):
    class Meta:
        model = product
        fields = '__all__'
    def create(self,validated_data):
        return product.objects.create(**validated_data)


class registererializer(serializers.ModelSerializer):
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

# class ViewPlantSerializer(serializers.ModelSerializer):
#     class Meta:
#         model=PetData
#         fields='__all__'
#         def create(self,validated_data):
#             return PetData.objects.create(**validated_data)