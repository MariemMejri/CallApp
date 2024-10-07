import 'package:flutter/material.dart';
import 'package:tp1/constant/myColors.dart';

ThemeData LightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: myBlack,
    primary: myBlue,
    secondary: myGrey,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ), // ColorScheme.light
);
