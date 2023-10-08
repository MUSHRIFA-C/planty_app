import 'dart:convert';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class ViewFavoriteItems{
  Future<List<Favorite>> getFavoriteItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = (prefs.getInt('login_id') ?? 0 ) ;
    final urls = APIConstants.url + APIConstants.viewFavoriteItem + userId.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<Favorite> data =  body['data'].map<Favorite>((e) => Favorite.fromJson(e)).toList();
      return data;

    } else {
      List<Favorite> data = [];
      return data;
    }
  }
}