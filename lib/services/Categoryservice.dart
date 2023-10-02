import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/cart.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:http/http.dart' as http;

class ViewCategoryApi {

  /*static Future<ViewCategoryItemsModel> getPetDetails(int id) async {
    final urls = APIConstants.url + APIConstants.viewSinglePetDetails + id.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return ViewCategoryItemsModel.fromJson(body['data']);
    } else {
      throw Exception('Failed to load pet details');
    }
  }*/

  /*static Future<ViewCategoryItemsModel> getAllPetDetails() async {
    final urls = APIConstants.url + APIConstants.viewAllPetDetails;
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return ViewCategoryItemsModel.fromJson(body['data']);
    } else {
      throw Exception('Failed to load pet details');
    }
  }*/

  Future<AddtoCart> addtoCart({required BuildContext context,
    required int userId,
    required int productId
  }) async {
    var urls = Uri.parse('${APIConstants.url + APIConstants.addtoCartItem}');
    var datas = {

      "user": userId.toString(),
      "item": productId.toString(),
      "quantity": "1",
    };
    try {
      var response = await Apiservice().authData(datas,APIConstants.addtoCartItem);
      var body = json.decode(response.body);
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
        return AddtoCart.fromJson(jsonDecode(response.body));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
      }
    }
    catch (e) {
      throw e.toString();
    }
    throw 'Unexpected error occurred';
  }

  static Future<List<AddtoCart>> getSinglecartItems(int userId) async{
    final urls = APIConstants.url + APIConstants.cartItemsview + userId.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<AddtoCart> data =  body['data'].map<AddtoCart>((e) => AddtoCart.fromJson(e)).toList();
      return data;

    } else {
      List<AddtoCart> data = [];
      return data;
    }
  }
}