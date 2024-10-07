import 'package:flutter/material.dart';
import 'package:tp1/pages/home_page.dart';
import 'package:tp1/pages/login_page.dart';
import 'package:tp1/themes/light_mode.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),
      theme: LightMode,
    );
  }
}
