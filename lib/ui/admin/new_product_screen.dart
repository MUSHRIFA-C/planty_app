import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/addproductservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class Aaddproducts extends StatefulWidget {
  const Aaddproducts({Key? key}) : super(key: key);

  @override
  State<Aaddproducts> createState() => _AaddproductsState();
}

class _AaddproductsState extends State<Aaddproducts> {

  TextEditingController plantIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController categoryController = TextEditingController();



  /*ViewCategoryApi viewcategories = ViewCategoryApi();*/
  String? category;
  List items=[
    "Recommended",
    "Garden",
    "Outdoor",
    "Indoor",
  ];

  String? dropDownvalue;
  File? imageFile;

  late  final _filename;
  late  final bytes;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),

                ],
              ),
            ),
          );
        });
  }
  _getFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          _filename = basename(imageFile!.path);
          print("file$_filename");
          final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
          final _extension = extension(imageFile!.path);
          print("imageFile:${imageFile}");
          print(_filename);
          print(_nameWithoutExtension);
          print(_extension);
        });
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from gallery: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

   // final Product newProduct = Product(data: Data());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,)),
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: plantIdController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'plantId ',
                  hintText: 'plantId ',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: priceController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Price',
                  hintText: 'Price',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: sizeController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'size',
                  hintText: 'size',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Description',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: humidityController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Humidity ',
                  hintText:  'Humidity ',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: temperatureController,
                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: 'Temparature ',
                  hintText: 'Temparature ',
                ),
              ),
            ),


            SizedBox(height: 20,),
/*            FutureBuilder<List<cate>>(
              future: viewcategories.getCategories(),
              builder: (BuildContext context, AsyncSnapshot<List<ViewCategoryModel>> snapshot) {
                if (snapshot.hasData) {
                  List<ViewCategoryModel> categories = snapshot.data!;
                  return SizedBox(
                    width: 350,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      hint: Text('Categories'),
                      value: dropDownvalue,

                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id.toString(),
                          child: Text(
                            '${category.name} ',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (type) {
                        setState(() {

                          dropDownvalue = type;
                          print("dropdownvalue $dropDownvalue");
                        });
                      },
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),*/
            /*DropdownButtonFormField<String>(
              iconSize: 20,
              decoration: const InputDecoration(hintText: 'Product Category'),
              value: newProduct.data!.category,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  newProduct.data!.category = value;
                  dropDownvalue = newProduct.data!.category;
                  print("dropDownvalue $dropDownvalue");
                });
              },
            ),*/
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

            SizedBox(height: 60,),
            Container(

              child: imageFile == null
                  ? Container(
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                      ),
                      onPressed: () {
                        //    _getFromGallery();
                        _showChoiceDialog(context);
                      },
                      child: Text("Upload Image"),
                    ),
                    Container(
                      height: 40.0,
                    ),

                  ],
                ),
              ): Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.file(
                      imageFile!,
                      width: 100,
                      height: 100,
                      //  fit: BoxFit.cover,
                    ),
                  ), ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Constants.primaryColor,
                    ),
                    onPressed: () {
                      //    _getFromGallery();
                      _showChoiceDialog(context);
                    },
                    child: Text("Upload Image"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Constants.primaryColor,
                ),
                child: const Text('Submit',style: TextStyle(fontSize: 25),),
                onPressed: () {
                  AddProductApi.product(context,
                    nameController.text,
                    priceController.text,
                    sizeController.text,
                    descriptionController.text,
                    /*ratingController.text,*/
                    humidityController.text,
                    temperatureController.text,
                    dropDownvalue.toString(),
                    imageFile,
                  );
                  print("product $nameController.text");
                },
              ),
            ),


          ],
        ),
      ),

    );
  }
}