
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/viewproduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/services/updatePlants.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Productupdate extends StatefulWidget {
  final int id;

  Productupdate({required this.id});

  @override
  State<Productupdate> createState() => _ProductupdateState();
}

class _ProductupdateState extends State<Productupdate> {

  late SharedPreferences prefs;
  late int id;

  TextEditingController plantIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String name = '';
  String price = '';
  String size = '';
  String description = '';
  String humidity = '';
  String temperature = '';
  String category = '';
  File? imageFile;

  late Product product;
  int currentTab = 2;
  var dropdownvalue;
  List _loaddata = [];
  var data;


  @override
  void initState() {
    super.initState();
    print("id${widget.id}");
    _fetchData();
  }
  Future<void> _fetchData() async {
    try {
      setState(() {
        name =data['data']['name'];
        price = data['data']['price'];
        size = data['data']['size'];
        description = data['data']['description'];
        humidity = data['data']['humidity'];
        temperature =data['data']['temparature'];
        nameController.text=name;
        priceController.text=price;
        descriptionController.text=description;
        sizeController.text=size;
        humidityController.text=humidity;
        temperatureController.text=temperature;

      });
    } catch (e) {
      // Handle errors here, e.g., show an error message
      print('Failed to fetch user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          ),
          title: Text('Edit product'),
        ),
        body: Center(

          child: FutureBuilder<Map<String, dynamic>>(
            future: ViewProductService().fetchData(widget.id), // Call the API function

            builder: (context, snapshot) {
              if (
              snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (
              snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}');
              } else if (
              !snapshot.hasData || snapshot.data == null) {
                return Text('No data available');
              } else {

                data = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
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
                          controller: priceController,
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
                          controller: categoryController,
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 70,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ProductUpdateService.updateProduct(
                                  context,
                                  nameController.text,
                                  priceController.text,
                                  sizeController.text,
                                  humidityController.text,
                                  temperatureController.text,
                                  descriptionController.text,
                                  categoryController.text,
                                  imageFile,

                                );
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Constants.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ProductUpdateService.deleteProduct(context, widget.id);
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Constants.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25,),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}