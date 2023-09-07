import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/login.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/updateProfile.dart';
import 'package:flutter_onboarding/services/viewProfile.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/profile_widget.dart';
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

  String fullname = '';
  String email = '';

  UpdateProfile updateUserProfile = UpdateProfile();

  void getoutId() async {
    prefs = await SharedPreferences.getInstance();
    outid = (prefs.getInt('user_id') ?? 0);

    fetchUserDetails(outid);
  }


  Future<void> fetchUserDetails(int uId) async { // Change return type to void
    try {
      final details = await ViewProfileAPI().getViewProfile(uId);
      userDetails = details;
      if (userDetails != null) { // Check if userDetails is not null
        setState(() {
          fullname = userDetails!.fullname ?? ''; // Use null-aware operator
          email = userDetails!.email ?? ''; // Use null-aware operator
          fullnameController.text = fullname;
          emailController.text = email;
        });
      } else {
        // Handle the case where userDetails is null
      }
    } catch (e) {
      print('Failed to fetch user details: $e');
      // Handle the error here
    }
  }

  @override
  void initState() {
    super.initState();
    getoutId();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      ExactAssetImage('assets/images/profile.jpg'),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 5.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        fullname,
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 20,
                        ),
                      ),
                      /*SizedBox(
                        height: 24,
                        child: Image.asset("assets/images/verified.png"),
                      ),*/
                    ],
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Constants.blackColor.withOpacity(.3),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProWidget(
                        icon: Icons.person,
                        title: 'My Profile',
                        email: email,
                        fullname: fullname,
                        controller: null,
                      ),

                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SignIn(), // Replace with your login screen widget
                          ));
                        },
                        child: ProWidget(
                          icon: Icons.logout,
                          title: 'Log Out',
                          fullname: '',
                          email: '',
                          controller: null,
                        ),
                      ),
                    ],

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
