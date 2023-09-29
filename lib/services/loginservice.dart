import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/login.dart';
import 'package:flutter_onboarding/ui/admin/home_screen.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Api {
  late SharedPreferences localStorage;
  String role = "";
  String user = "user";
  String admin = "admin";

  Future<void>login(BuildContext context, Login log) async {
    try {

      var urls = APIConstants.url + APIConstants.login;

      var response = await http.post(
          Uri.parse(urls),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(log.toJson()), );
      var body = json.decode(response.body);
      print(body);

      if (body['success']==true) {
        role = body['data']['role'];
        print(role);


        localStorage = await SharedPreferences.getInstance();
        localStorage.setString('role', role.toString());
        localStorage.setInt('login_id', body['data']['login_id']);

        print('login_id ${body['data']['login_id']}');


        if(role == user){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const RootPage(),
                  type: PageTransitionType.bottomToTop));
        }
        else if(role == admin) {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => Homescreen()));
        }
      } else {
        print('Error - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

