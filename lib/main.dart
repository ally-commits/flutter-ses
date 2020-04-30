import 'package:flutter/material.dart';
import 'package:sra/screens/login_screen.dart';

import 'screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primaryColor: Color.fromRGBO(42, 91, 209, 1),
        fontFamily: 'Montserratcd'
      ),
      home: AuthController(),
    );
  }
}

class AuthController extends StatefulWidget {
  @override
  _AuthControllerState createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}

