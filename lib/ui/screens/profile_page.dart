import 'dart:convert';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/updateProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  late int outid;
  User? userDetails;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String name = '';
  String email = '';
  String contact = '';

  UpdateProfile updateUserProfile = UpdateProfile();

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    outid = (prefs.getInt('login_id') ?? 0);
    final urls = APIConstants.url + APIConstants.viewProfile + outid.toString();
    var response = await http.get(Uri.parse(urls));
    var body = json.decode(response.body);
    print(body);
    setState(() {
      name = body['data']['fullname'];
      email = body['data']['email'];
      contact = body['data']['phonenumber'];

      fullnameController.text = name;
      emailController.text = email;
      contactController.text = contact;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SignIn()),
          (route) => false,
    );
  }

  Future<void> showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                logout();
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user details when the widget initializes
    _viewPro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Constants.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 45, left: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    icon: Icon(Icons.arrow_back, size: 28, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            name != null
                ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Constants.primaryColor,
                  child: Text(
                    name[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 41,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 16),
            _viewPro != null
                ? Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 70),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Constants.primaryColor,
                                    blurRadius: 16,
                                    offset: Offset(2, 7))
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey.shade700),
                                    ),
                                    TextField(
                                      controller: fullnameController,
                                      decoration: InputDecoration(
                                        hintText: "${name}",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey.shade700),
                                    ),
                                    TextField(
                                      controller: contactController,
                                      decoration: InputDecoration(
                                          hintText: "${contact}",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey.shade700),
                                    ),
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "${email}",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 65),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 2,
                                        offset: Offset(4, 4),
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                child: TextButton(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    updateUserProfile.updateProfile(context, fullnameController.text,
                                        contactController.text, emailController.text);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 2,
                                    offset: Offset(4, 4),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: showLogoutConfirmationDialog,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
