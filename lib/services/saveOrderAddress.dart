import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/orderAddress.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/screens/orderConfirmation.dart';

class SaveOrderAddress{
  Future <OrderAddress> saveOrderAddress (
      BuildContext context,
      int uid,
      String pincode,
      String city,
      String state,
      String area,
      String buildingName,
      String landmark,
      String addressType
      ) async {
    var orderaddress= {
      "user": uid.toString(),
      "pincode": pincode,
      "city":city,
      "state": state,
      "area": area,
      "buildingName":buildingName,
      "landmark": landmark,
      "addressType":addressType,
    };
    try {
      var response = await Apiservice().authData(orderaddress,APIConstants.saveOrderAddress+uid.toString());
      var body = json.decode(response.body);
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmation()));
        return OrderAddress.fromJson(jsonDecode(response.body));
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
}