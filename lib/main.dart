import 'package:flutter/material.dart';
import 'package:hackathonapp/screens/LoginScreen.dart';
import 'package:hackathonapp/screens/SignUpScreen.dart';
import 'package:hackathonapp/screens/JoinACall.dart';
import 'package:hackathonapp/screens/starting_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartingScreen.id,
      routes: {
        StartingScreen.id: (context) => StartingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        FindCallsPage.id: (context) => FindCallsPage(),
      },
    );
  }
}
