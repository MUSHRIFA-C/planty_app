
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';

class CustomTextfield extends StatefulWidget {

  final IconData icon;
  final bool obscureText;
  final String hintText;
  final InputDecoration? decoration;
  final TextEditingController? controller;


  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required this.controller,
    this.decoration,

  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {

  bool passwordVisible=false;
  bool _obscureText=false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,

        prefixIcon: Icon(widget.icon,
          color: Constants.blackColor.withOpacity(.3),),
        hintText: widget.hintText,
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
}