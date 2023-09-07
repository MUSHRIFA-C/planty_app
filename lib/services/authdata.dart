import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  authData(data, apiUrl) async {
    var fullUrl = APIConstants.url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: data,
    );
  }

  postData(apiUrl) async {
    var fullUrl = APIConstants.url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
    );
  }

  putData(data, apiUrl) async {
    var fullUrl = APIConstants.url + apiUrl;
    return await http.put(
      Uri.parse(fullUrl),
      body: data,
    );
  }

  getData(apiUrl) async {
    var fullUrl = APIConstants.url + apiUrl;
    // await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      // headers: _setHeaders()
    );
  }

  deleteData(apiUrl) async {
    var fullUrl = APIConstants.url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}
