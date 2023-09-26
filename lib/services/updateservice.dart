import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/ui/admin/products_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUpdateService {
  static Future<void> updateProduct(
      BuildContext context,
      String name,
      String price,
      String size,
      String description,
      /*String rating,*/
      String humidity,
      String temperature,
      String category,
      File? imageFile
      ) async {

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final urls = APIConstants.url + APIConstants.updateproduct;
    print(urls);

    var request = await http.MultipartRequest('POST', Uri.parse(urls));
    request.fields["plantname"] = name;
    request.fields["ptprice"] = price;
    request.fields["ptdescription"] = description;
    request.fields["ptsize"] = size;
    request.fields["pthumidity"] = humidity;
    request.fields["pttemp"] = temperature;
    /*request.fields["ptrating"] = rating;*/
    request.fields["category"] = category;

    print("request ${request.fields}");

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Product Updated successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Productview()),
      );

    } else {
      print('Error Updating event. Status code: ${response.statusCode}');
    }
  }

  static Future<void> deleteProduct(BuildContext context, int id) async {
    var res = await http.get(Uri.parse(APIConstants.product));

    if (res.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Productview()),
      );
      Fluttertoast.showToast(
        msg: "Event Deleted Successfully",
        backgroundColor: Colors.grey,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Currently there is no data available",
        backgroundColor: Colors.grey,
      );
    }
  }
}
