# Generated by Django 4.2.1 on 2023-10-04 10:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("plantsy", "0004_alter_cart_category"),
    ]

    operations = [
        migrations.AlterField(
            model_name="cart",
            name="image",
            field=models.ImageField(upload_to="images/"),
        ),
    ]
