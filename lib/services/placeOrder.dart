import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/ui/screens/orderSuccessMessage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrderAPI{
  static Future<void> placeOrder(BuildContext context,String orderAddress,String userName, String contactNum) async {

    String datetime1='';
    DateTime datetime = DateTime.now();
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);

    SharedPreferences localstorage = await SharedPreferences.getInstance();
    int userId = (localstorage.getInt('login_id') ?? 0 ) ;
    try{
      var data={
        "user": userId.toString(),
        "date": datetime1,
        "orderAddress" : orderAddress,
        "userName" : userName,
        "contactNum" : contactNum,
      };
      print(data);
      final urls = APIConstants.url + APIConstants.placeOrder;
      var response = await http.post(Uri.parse(urls),body: data);
      var body = json.decode(response.body);
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderSuccessMessage()));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
      }
    }
    catch(e){
      throw e.toString();
    }
  }
}