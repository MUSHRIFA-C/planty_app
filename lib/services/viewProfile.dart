import 'dart:convert';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:http/http.dart' as http;


class ViewProfileAPI{

  Future<User> getViewProfile(int userId) async {
    final urls = APIConstants.url + APIConstants.viewProfile + userId.toString();
    var response = await http.get(Uri.parse(urls));
    var body = json.decode(response.body);
    print('profile${body}');
    if (response.statusCode == 200) {
      return User.fromJson(body['data']);
    }
    else {
      throw Exception('Failed to load user details');
    }
  }
}