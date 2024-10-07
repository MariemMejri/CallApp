import 'package:flutter/material.dart';
import 'package:tp1/constant/myColors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;

  const MyTextField(
      {super.key, required this.hintText, required this.obsecureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        
        obscureText: obsecureText,
        style: TextStyle(color: Colors.white), 
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.secondary,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White underline
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myBlue), // White underline when focused
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Example for error state
          ),
        ),
      ),
    );
  }
}
