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
  List items=[
    "Recommended",
    "Garden",
    "Outdoor",
    "Indoor",
  ];
  String? dropDownvalue;

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
  //  _fetchData();
    _viewPro();
  }
  late int id;
  String name='';
  String price='';
  String description='';
  String size='';
  String humidity='';
  String temperature='';
  String category='';
  double rating= 0.0;
  String expdate='';

  late SharedPreferences prefs;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController expdateController = TextEditingController();



  int currentTab = 2;

  Future<void> _viewPro() async {
    int id=widget.id;
    var res = await Apiservice().getData(APIConstants.viewsingleproduct + id.toString());
    var body = json.decode(res.body);
    print(body);

    setState(() {
      name = body['data']['name'];
      price = "${body['data']['price']} ₹"==null?'0' : "${body['data']['price']} ₹";
      description = body['data']['description'];
      size = body['data']['size'];
      humidity = "${body['data']['humidity']} %"==null?'0' : "${body['data']['humidity']} %";
      temperature = "${body['data']['temparature']}°C"==null?'0':"${body['data']['temparature']}°C";
      category= body['data']['category']==null?'Not found':body['data']['category'];
      rating= body['data']['rating']==null?0.0:body['data']['rating'];
      expdate= body['data']['expdate']==null?'Not found':body['data']['expdate'];
      print("tem$temperature");

      nameController.text = name;
      priceController.text=price;
      descriptionController.text=description;
      sizeController.text=size;
      humidityController.text=humidity;
      temperatureController.text=temperature;
      dropDownvalue=category;

    });
  }

  Future<void> _updateplant(String name, String price,String expdate,
      String size, String description,
      double rating,String humidity,
      String temperature, String category,/*File? imageFile*/) async {
    int id=widget.id;
    prefs = await SharedPreferences.getInstance();

    var uri = Uri.parse(APIConstants.url +'/api/Update_productAPIView/'+ widget.id.toString());
    //final urls = APIConstants.url + APIConstants.updateproduct + widget.id.toString();

    var request = await http.MultipartRequest('PUT', uri);
    request.fields["plantname"] = name;
    request.fields["price"] = price;
    request.fields["ptdescription"] = description;
    request.fields["ptsize"] = size;
    request.fields["pthumidity"] = humidity;
    request.fields["pttemp"] = temperature;
    request.fields["ptrating"] = rating.toString();
    request.fields["category"] = category;
    request.fields["expdate"] = expdate;


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
    var res = await Apiservice().deleteData('/api/Delete_productAPIView/' + widget.id.toString());
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Constants.primaryColor,Colors.white],
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
            SizedBox(height: 20,),
            Card(
              child: SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)) ,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    hint: Text('CATEGORY'),
                    value: dropDownvalue,
                    items: items
                        .map((type) => DropdownMenuItem<String>(
                      value: type.toString(),
                      child: Text(
                        type.toString(),
                        style: TextStyle(color: Colors.black,fontSize: 16),
                      ),
                    ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        dropDownvalue=type;
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
                   _updateplant(nameController.text, priceController.text.replaceAll('₹', ''),
                       expdate, sizeController.text, descriptionController.text,
                       rating, humidityController.text.replaceAll('%', ''), temperatureController.text.replaceAll('°C', ''),
                       dropDownvalue.toString());
                    /* _update(
                        nameController.text,
                        priceController.text,
                        descriptionController.text,
                        sizeController.text,categoryController.text
                        humidityController.text,
                        temperatureController.text,
                        ratingController.text,
                        ,
                        expdateController.text,

                      );*/
                    },
                    child: Text("Update",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
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