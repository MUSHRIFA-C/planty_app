import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/addproductservice.dart';
import 'package:flutter_onboarding/ui/admin/products_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddProductApi {

  static Future<Product> product(BuildContext context, String name, String price,
      String size, String description, /*String rating,*/ String humidity,
      String temperature, String category,File? imageFile ) async {

    SharedPreferences localstorage = await SharedPreferences.getInstance();

    /*int? userId = localstorage.getInt('user_id');

    if (userId == null) {
      throw Exception('User ID is null');

    }*/

      final urls = APIConstants.url + APIConstants.product;
      print(urls);

      var request = await http.MultipartRequest('POST', Uri.parse(urls));
      /*request.fields["plantId"] = pl.toString();*/
      request.fields["plantname"] = name;
      request.fields["ptprice"] = price;
      request.fields["ptdescription"] = description;
      request.fields["ptsize"] = size;
      request.fields["pthumidity"] = humidity;
      request.fields["pttemp"] = temperature;/*
      request.fields["ptrating"] = rating;*/
      request.fields["category"] = category;

      print("request ${request.fields}");

      if (imageFile != null) {
        final imageStream = http.ByteStream(imageFile!.openRead());
        final imageLength = await imageFile!.length();

        final multipartFile = await http.MultipartFile(
          'images',
          imageStream,
          imageLength,
          filename: imageFile.path.split('/').last,
        );
        request.files.add(multipartFile);
        print("filename ${imageFile.path.split('/').last}");
      } else {
        // Handle the case where imageFile is null or provide a default image
        // You can choose to throw an error, use a default image, or handle it differently.
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        print('Form submitted successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));

        return Product.fromJson(jsonDecode(await response.stream.bytesToString()));
      } else {
        print('Error submitting form. Status code: ${response.statusCode}');
        throw Exception('Failed to add product');
      }
    }
  }

