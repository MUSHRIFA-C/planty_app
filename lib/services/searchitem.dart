import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/screens/searchResult.dart';

class SearchItem{

  static Future<void> searchItems(BuildContext context, String text) async {
    var data = {
      "search": text,
    };

    try {
      var response = await Apiservice().authData(data,APIConstants.searchItem);
      var body = json.decode(response.body);
      if (body['success'] == true) {
        List _data=body['data'];
        var items=_data.map((e) => DetailData.fromJson(e)).toList();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(items:items)));

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