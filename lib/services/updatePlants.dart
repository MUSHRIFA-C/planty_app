import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdatePlants{

  Future<Product> updatePlant(BuildContext context,
      String name,
      String price,
      String size,
      String description,
      String humidity,
      String temperature,
      String category,
      String imageFile
      ) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int plantId = (prefs.getInt('id') ?? 0 ) ;
    print('product id ${plantId}');

    var plantData= {
      "name": name,
      "price": price,
      "size": size,
      "description": description,
      "humidity": humidity,
      "temperature": temperature,
      "category": category,
      "image": imageFile,
    };

    try{
      var response = await Apiservice().putData(plantData, APIConstants.updateproduct+ plantId.toString());
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
        return Product.fromJson(jsonDecode(response.body));
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





/*import 'dart:convert';
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

*//*request.fields["ptrating"] = rating;*//*

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
}*/

