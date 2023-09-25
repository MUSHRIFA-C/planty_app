import 'dart:convert';
import 'dart:math';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:http/http.dart' as http;

class ViewProductService {
  static Future<List<Product>> getProducts() async {


    try {
      final url = APIConstants.url+ APIConstants.viewproduct;
      print('url$url');
      var response = await http.get(Uri.parse(url));

      /*final response = await http.get(Uri.parse(APIConstants.viewproduct));*/
      print(APIConstants.url+ APIConstants.viewproduct);

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        print("body$body");

        List<Product> data = List<Product>.from(
            body['data'].map((e) => Product.fromJson(e)).toList());

        print("data$data");

        return data;


      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
