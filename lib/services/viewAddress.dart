import 'dart:convert';

import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/orderAddress.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewOrderAddress{

  Future<List<OrderAddress>> getOrderAddress() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = (prefs.getInt('user_id') ?? 0 ) ;
    final urls = APIConstants.url + APIConstants.viewOrderAddress + userId.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<OrderAddress> data =  body['data'].map<OrderAddress>((e) => OrderAddress.fromJson(e)).toList();
      return data;

    } else {
      List<OrderAddress> data = [];
      return data;
    }
  }

}