import 'package:flutter/material.dart';
import 'package:hackathonapp/main.dart';
import 'package:flutter/material.dart';
import 'package:hackathonapp/components/variables.dart';
import 'package:hackathonapp/screens/JoinACall.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'screen3';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVolunteer = false;
  bool talkWithVolunteer = false;
  bool isOnline = false;
  // String age;
  String emailorPhoneNumber;
  String password;
  String zoom;
  bool spinner = false;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  emailorPhoneNumber = value;
                  //Do something with the user input.
                },
                decoration: TextFieldDec.copyWith(
                  hintText: 'Phone Number or Email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: TextFieldDec.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              // TextField(
              //   keyboardType: TextInputType.number,
              //   textAlign: TextAlign.center,
              //   onChanged: (value) {
              //     age = value;
              //     //Do something with the user input.
              //   },
              //   decoration: TextFieldDec.copyWith(
              //     hintText: 'Enter Your Age',
              //   ),
              // ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FindCallsPage.id);
                      addAccount();
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: isVolunteer == true ? Colors.green : Colors.red,
                height: 50,
                width: 30,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isVolunteer == true ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        isVolunteer == true
                            ? 'I Am A Volunteer'
                            : 'I Am Not A Volunteer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVolunteer = true;
                      });
                    },
                    child: Container(
                      color: isVolunteer == true ? Colors.green : Colors.black54,
                      height: 50,
                      width: 120,
                      child: Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVolunteer = false;
                      });
                    },
                    child: Container(
                      color: isVolunteer == false ? Colors.red : Colors.black54,
                      height: 50,
                      width: 120,
                      child: Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addAccount(){
    databaseReference.child(emailorPhoneNumber).set({
      'identifier' : emailorPhoneNumber,
      'password' : password,
      // 'age' : age,
      'volunteer' : isVolunteer,
      'isOnline' : isOnline,
      'ZoomLink' : zoom,
      'wantsToTalkToVolunteer' : talkWithVolunteer,
      'person' : null
    });
  }
}
