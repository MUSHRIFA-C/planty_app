
import 'dart:convert';
import 'dart:io';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/ui/admin/products_screen.dart';
import 'package:http/http.dart' as http ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Productupdate extends StatefulWidget {
  final int id;

  Productupdate({required this.id});

  @override
  State<Productupdate> createState() => _ProductupdateState();
}

class _ProductupdateState extends State<Productupdate> {
  List _loaddata=[];

  _fetchData() async {
    final url = APIConstants.url+ APIConstants.viewproduct;

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    _viewPro();
  }
  String name='';
  String price='';
  String description='';
  String size='';
  String humidity='';
  String temperature='';
  String category='';

  late SharedPreferences prefs;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController categoryController = TextEditingController();


  int currentTab = 2;
  Future<void> _viewPro() async {
    int id=widget.id;

    var res = await Apiservice().getData(APIConstants.viewsingleproduct + id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      description = body['data']['description'];
      price = body['data']['price'];
      size = body['data']['size'];
      humidity = body['data']['humidity'];
      temperature = body['data']['temperature'];




      nameController.text = name;
      descriptionController.text=description;
      sizeController.text=size;
      priceController.text=price;
      humidityController.text=humidity;
      temperatureController.text=temperature;


    });
  }


  // Initial Selected Value
  Future<void> _update(String name, String price,
      String size, String description,
      /*String rating,*/ String humidity,
      String temperature, String category,File? imageFile) async {
    int id=widget.id;
    prefs = await SharedPreferences.getInstance();

    final urls = APIConstants.url + APIConstants.updateproduct + id.toString();
    /*var uri = Uri.parse(APIConstants().url+'/api/Update_productAPIView/'+id.toString());*/ // Replace with your API endpoint

    // var http;
    var request = await http.MultipartRequest('POST', Uri.parse(urls));

    request.fields["plantname"] = name;
    request.fields["ptprice"] = price;
    request.fields["ptdescription"] = description;
    request.fields["ptsize"] = size;
    request.fields["pthumidity"] = humidity;
    request.fields["pttemp"] = temperature;/*
    request.fields["ptrating"] = rating;*/
    request.fields["category"] = category;

    print(request.fields);
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Product Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Productview()));
    } else {
      print('Error Updating event. Status code: ${response.statusCode}');
    }
  }

  _deleteData(int id) async {
    var res = await http.get(Uri.parse(APIConstants.deleteproduct));
    if (res.statusCode == 200) {
      setState(() {

        Navigator.pushReplacement(
            context as BuildContext, MaterialPageRoute(builder: (context) => Productview()));
        Fluttertoast.showToast(
          msg: "Event Deleted Successfully",
          backgroundColor: Colors.grey,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var dropdownvalue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Constants.primaryColor],
            ),
          ),
        ),
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,)),
        title: Text('Add product'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: sizeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: humidityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: temperatureController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)) ,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    hint: Text('Categories'),
                    value: dropdownvalue,
                    items: _loaddata
                        .map((type) => DropdownMenuItem<String>(
                      value: type['id'].toString(),
                      child: Text(
                        type['name'].toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        dropdownvalue = type!;
                      });
                    }),
              ),
            ),

            SizedBox(height: 70,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _update(nameController.text,
                          descriptionController.text,
                          sizeController.text,
                          priceController.text,
                          humidityController.text,
                          temperatureController.text,
                          categoryController.text,
                          dropdownvalue);
                    },
                    child: Text("Edit",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      _deleteData(widget.id);
                    },
                    child: Text("Delete",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 25,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}