import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/viewproduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/services/updateservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_onboarding/const/api_constants.dart';

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


  @override
  void initState() {
    super.initState();
    print("id${widget.id}");
    _fetchData(widget.id);
  }
  Future<void> _fetchData(int uId) async {
    try {
      final details = await ViewProductService().getViewProduct(uId);
      if (details != null) {
        setState(() {
          product = details;
          if (product.detaildata != null && product.detaildata!.isNotEmpty) {
            // Check if detaildata is not null and not empty
            name = product.detaildata![0].name!;
            price = product.detaildata![0].price!;
            size = product.detaildata![0].size!;
            nameController.text = name;
            priceController.text = price;
            sizeController.text = size;
          } else {
            // Handle the case where detaildata is null or empty (optional)
            print('Failed to fetch user details: detaildata is null or empty');
          }
        });
      } else {
        // Handle the case where details is null (optional)
        print('Failed to fetch user details: details is null');
      }
    } catch (e) {
      // Handle errors here, e.g., show an error message
      print('Failed to fetch user details: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
        ),
        title: Text('Edit product'),
      ),
      body: SingleChildScrollView(
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
                        /*dropdownvalue,*/
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
      ),
    );
  }
}
