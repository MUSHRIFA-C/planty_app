import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:http/http.dart' as http;

class RatePlantAPI {
  static Future<void> ratePlants(BuildContext context,int plntId, double rate) async {
    try{
      final urls=APIConstants.url + APIConstants.ratePlants + plntId.toString();
      print(urls);
      var data = {
        "rate" : rate.toString()
      };
      print('data = $data');
      var response = await http.put(Uri.parse(urls),body: data);
      var body = json.decode(response.body);
      if (body['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
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