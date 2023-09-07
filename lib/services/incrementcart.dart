import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:http/http.dart' as http;


class CartQuantityIncrementAPI{

  Future<void> cartQutyIncre(int pId) async{
    final urls = APIConstants.url + APIConstants.quantityIncrement + pId.toString();
    print(urls);
    var response = await http.put(Uri.parse(urls));
    var body = json.decode(response.body);
    if(response.statusCode==200){
      print('object');
    }
  }
}