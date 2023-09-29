import 'dart:convert';
import 'package:flutter_onboarding/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_onboarding/const/api_constants.dart';

class ViewUserplant {
  static Future<Product> getPlants() async {
    try {
      final url = APIConstants.url+ APIConstants.viewproduct;
      print('url$url');
      var response = await http.get(Uri.parse(url));

      print(APIConstants.url+ APIConstants.viewproduct);

      if (response.statusCode == 200) {

        var body = json.decode(response.body);
        print("body$body");
        Product data = Product.fromJson(body);
        return data;


      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}