import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateProfile{

  Future<User> updateProfile(BuildContext context,
      String name, String phone_number, String email) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = (prefs.getInt('login_id') ?? 0 ) ;
    print('Outsider id ${userId}');

    var userData= {
      "fullname": name,
      "phonenumber": phone_number,
      "email": email,
    };

    try{
      var response = await Apiservice().putData(userData, APIConstants.updateProfile+userId.toString());
      var body = json.decode(response.body);
      print(body);
      if(body['success'] == true){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message'],),
            ));
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const RootPage(),
                type: PageTransitionType.bottomToTop));
        return User.fromJson(jsonDecode(response.body));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message']),
            ));
      }
    }
    catch (e) {
     /* throw e.toString();*/
    }
    throw 'Unexpected error occurred';
  }
}