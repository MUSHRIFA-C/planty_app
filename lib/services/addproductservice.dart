import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductService {
  // Replace this with your API base URL
  static const String baseUrl = 'YOUR_API_BASE_URL';

  // Add product function
  static Future<bool> addProduct(
      String name,
      String description,
      String price,
      String size,
      String humidity,
      String temperature,
      String rating,
      String imageFilePath,
      String category,
      ) async {
    try {
      final uri = Uri.parse('$baseUrl/api/add_product');
      final request = http.MultipartRequest('POST', uri);

      // Add fields
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['price'] = price;
      request.fields['size'] = size;
      request.fields['humidity'] = humidity;
      request.fields['temperature'] = temperature;
      request.fields['rating'] = rating;
      request.fields['category'] = category;

      // Add image file
      final imageFile = File(imageFilePath);
      final imageStream = http.ByteStream(imageFile.openRead());
      final imageLength = await imageFile.length();
      final imageFileName = basename(imageFilePath);

      final multipartFile = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: imageFileName,
      );

      request.files.add(multipartFile);

      // Send the request
      final response = await request.send();

      if (response.statusCode == 201) {
        return true; // Product added successfully
      } else {
        return false; // Failed to add product
      }
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }
}