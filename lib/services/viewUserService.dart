import 'dart:convert';
import 'package:flutter_onboarding/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_onboarding/const/api_constants.dart';

class ViewUserService {
  static Future<List<User>> getUsers() async {
    try {

      final url = APIConstants.url + APIConstants.viewproduct;
      print('url$url');
      var response = await http.get(Uri.parse(url));

      //print(APIConstants.url + APIConstants.viewuser);


      //print("body$body");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        print("body$body");

        List<User> data = body['data'].map<User>((e) => User.fromJson(e)).toList();
        return data;

      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}