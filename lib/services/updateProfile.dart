

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/services/loginservice.dart';

import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile{
  var fullname;


  Future<User> updateProfile(BuildContext context, String name, String phoneNum, String email) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = (prefs.getInt('login_id') ?? 0 ) ;

    var userData= {
      "fullnameController": fullname,
      "phoneController": phoneNum,

      "emailController":email,
    };

    try{
      var response = await Apiservice().putData(userData, APIConstants.updateProfile+userId.toString());
      var body = json.decode(response.body);
      if(body['success'] == true){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(body['message'],),
            ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        return User.fromJson(jsonDecode(response.body));
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

