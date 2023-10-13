import 'dart:convert';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/OrderItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewAdminOrder{
  Future<List<Data>> getOrderItems() async{

    final urls = APIConstants.url + APIConstants.viewAllOrder;
    var response = await http.get(Uri.parse(urls));
    var body = json.decode(response.body);
    print("view body$body");
    if (response.statusCode == 200) {
      List<Data> data =  body['data'].map<Data>((e) => Data.fromJson(e)).toList();

      print(data);
      return data;
    } else {
      List<Data> data = [];
      return data;
    }
  }
}