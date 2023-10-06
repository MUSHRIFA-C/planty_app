import 'dart:convert';

import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/orderAddress.dart';
import 'package:http/http.dart' as http;


class viewSingleOrderAddressAPI{
  Future<OrderAddress> SingleOrderAddressAPI(int OrderId) async {
    final urls = APIConstants.url + APIConstants.viewSingleOrderAddress + OrderId.toString();
    var response = await http.get(Uri.parse(urls));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return OrderAddress.fromJson(body['data']);
    }
    else {
      throw Exception('Failed to load user details');
    }
  }
}