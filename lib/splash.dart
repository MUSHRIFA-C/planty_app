import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/ui/admin/home_screen.dart';
import 'package:flutter_onboarding/ui/onboarding_screen.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences localStorage;
  String user="user";
  String admin = "admin";
  String role="";


  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString("role") ?? '');

    if (role == user) {
      Navigator.pushReplacement(
          context, PageTransition(child: const RootPage(),
              type: PageTransitionType.bottomToTop));
    } else if(role == admin){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Homescreen()));
    }
    else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => OnboardingScreen()));

    }
  }



  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset('assets/images/logo.png',),
        ),
      ),
    );
  }
}