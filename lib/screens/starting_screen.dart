import 'package:flutter/material.dart';
import 'package:hackathonapp/main.dart';
import 'package:hackathonapp/screens/LoginScreen.dart';
import 'package:hackathonapp/screens/SignUpScreen.dart';
import 'package:hackathonapp/screens/JoinACall.dart';

class StartingScreen extends StatelessWidget {
  static const String id = 'startingscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0,),
                child: Center(
                  child: Text(
                    'Welcome\nto\nApp Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              child: Text(
                ' Log In ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              elevation: 10.0,
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 120.0),
            ),
            SizedBox(
              height: 90,
            ),
            Text(
              'Don\'t Have An Account?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
              elevation: 10.0,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 85.0),
            ),
          ],
        ),
      ),
    );
  }
}

