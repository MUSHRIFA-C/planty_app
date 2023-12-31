# Generated by Django 4.2.1 on 2023-09-21 19:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Categories",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("image", models.ImageField(max_length=500, upload_to="images/")),
                ("status", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="login",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("email", models.EmailField(max_length=50, null=True)),
                ("password", models.CharField(max_length=50, null=True)),
                ("role", models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name="register",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("fullname", models.CharField(max_length=50, null=True)),
                ("username", models.CharField(max_length=50, null=True)),
                ("email", models.EmailField(max_length=50, null=True)),
                ("phonenumber", models.CharField(max_length=50, null=True)),
                ("password", models.CharField(max_length=50, null=True)),
                ("role", models.CharField(max_length=50)),
                (
                    "log_id",
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE, to="plantsy.login"
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="product",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=50, null=True)),
                ("price", models.CharField(max_length=50, null=True)),
                ("description", models.CharField(max_length=500, null=True)),
                ("size", models.CharField(max_length=50, null=True)),
                ("humidity", models.CharField(max_length=50, null=True)),
                ("temparature", models.CharField(max_length=50, null=True)),
                ("rating", models.CharField(max_length=50, null=True)),
                ("image", models.ImageField(null=True, upload_to="images/")),
                (
                    "category",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="plantsy.categories",
                    ),
                ),
            ],
        ),
    ]
