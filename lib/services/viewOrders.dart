import 'dart:convert';

import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/OrderItems.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewOrderItems{
  Future<List<Data>> getOrderItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = (prefs.getInt('login_id') ?? 0 ) ;
    final urls = APIConstants.url + APIConstants.viewOrder + userId.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<Data> data =  body['data'].map<Data>((e) => Data.fromJson(e)).toList();
      return data;

    } else {
      List<Data> data = [];
      return data;
    }
  }
}