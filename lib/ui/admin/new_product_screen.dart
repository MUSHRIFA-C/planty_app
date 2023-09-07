import 'dart:convert';
import 'dart:io';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/ui/admin/products_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aaddproducts extends StatefulWidget {
  const Aaddproducts({Key? key}) : super(key: key);

  @override
  _AaddproductsState createState() => _AaddproductsState();
}

class _AaddproductsState extends State<Aaddproducts> {
  List<String> categories = [
    'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    // Add more categories as needed
  ];

  late SharedPreferences prefs;
  late String _filename;
  File? imageFile;
  late final bytes;
  int? plantId;// Declare plantId as an int with a nullable type

  TextEditingController nameController = TextEditingController(); // Add this
  TextEditingController priceController = TextEditingController(); // Add this
  TextEditingController sizeController = TextEditingController(); // Add this
  TextEditingController humidityController = TextEditingController(); // Add this
  TextEditingController temperatureController = TextEditingController(); // Add this
  TextEditingController descriptionController = TextEditingController(); // Add this
  TextEditingController ratingController = TextEditingController();





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
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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

  TextFormField _buildTextFormField(String hintText, TextEditingController controller, String? initialValue) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        // Handle text field changes
      },
    );
  }

  Widget build(BuildContext context) {
    final Product newProduct = Product(data: Data());

    Data? newProductData = Data();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          _showChoiceDialog(context);
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Add an Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextFormField('Product Name', nameController, newProduct.data!.name),
              _buildTextFormField('Product Price', priceController, newProduct.data!.price),
              _buildTextFormField('Product Size', sizeController, newProduct.data!.size),
              _buildTextFormField('Product Rating', ratingController, '0' /* or a default value */), // Initial rating
              _buildTextFormField('Product Humidity', humidityController, '0' /* or a default value */), // Initial humidity
              _buildTextFormField('Product Temperature', temperatureController, '0' /* or a default value */), // Initial temperature
              _buildTextFormField('Product Description', descriptionController, newProduct.data!.description),
              DropdownButtonFormField<String>(
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
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductsScreen(plantId: plantId ?? 0), // Provide a default value or handle the null case
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade800,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*
class Data {
  String? name;
  String? price;
  String? description;
  String? size;
  String? humidity;
  String? temperature;
  String? rating;
  String? image;
  String? category;

  Data({
    this.name,
    this.price,
    this.description,
    this.size,
    this.humidity,
    this.temperature,
    this.rating,
    this.image,
    this.category,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['size'] = this.size;
    data['humidity'] = this.humidity;
    data['temperature'] = this.temperature;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
*/
