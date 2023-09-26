import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/user.dart';


class Register {
  Future<void> register(BuildContext context, User user) async {
    try {
      var urls = APIConstants.url + APIConstants.register;

      var response = await http.post(
        Uri.parse(urls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // Specify JSON content type.
        },
        body: jsonEncode(user.toJson()), // Encode user data as JSON.
      );

      if (response.statusCode == 201) {
        print('Success');

        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));

      } else {
        print('Error - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  login(BuildContext context, User user) {}
}
