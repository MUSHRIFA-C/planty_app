
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/orderAddress.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/screens/changeAddress.dart';

class UpdateOrderAddressAPI{

  Future<OrderAddress> updateOrderAddress(BuildContext context, int OId,String name, String contact, String pincode,String city,String state,String area,String buildingName,String landmark,String addressType) async{

    var userData= {
      "name": name,
      "contact": contact,
      "pincode":pincode,
      "city": city,
      "state": state,
      "area": area,
      "buildingName": buildingName,
      "landmark": landmark,
      "addressType": addressType,
    };

    try{
      var response = await Apiservice().putData(userData, APIConstants.updateOrderAddress+OId.toString());
      var body = json.decode(response.body);
      if(body['success'] == true){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message'],),
            ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeAddress()));
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