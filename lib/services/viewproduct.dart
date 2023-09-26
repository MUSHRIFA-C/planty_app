import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/product.dart';

class ViewProductService {
  static Future<Product> getProducts() async {


    try {
      final url = APIConstants.url+ APIConstants.viewproduct;
      print('url$url');
      var response = await http.get(Uri.parse(url));

      /*final response = await http.get(Uri.parse(APIConstants.viewproduct));*/
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

  Future<Product> getViewProduct(int id) async {

    final urls = APIConstants.url + APIConstants.viewsingleproduct + id.toString();
    var response = await http.get(Uri.parse(urls));
    var body = json.decode(response.body);
    print(body);
    if (response.statusCode == 200) {
      return Product.fromJson(body['data']);
    }
    else {
      throw Exception('Failed to load product details');
    }
  }
}