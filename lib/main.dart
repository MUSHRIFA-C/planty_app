import 'package:flutter/material.dart';
import 'package:flutter_onboarding/splash.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'Onboarding Screen',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
