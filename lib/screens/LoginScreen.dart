import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathonapp/main.dart';
import 'package:flutter/material.dart';
import 'package:hackathonapp/components/variables.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hackathonapp/screens/JoinACall.dart';
import 'package:firebase_database/firebase_database.dart';

String emailorPhoneNumber;

class LoginScreen extends StatefulWidget {
  static const String id = 'screen2';
  // final String userId;
  // LoginScreen(this.userId);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final String username;
  // _LoginScreenState(this.username);
  var dbTemp;
  bool isVolunteer = false;
  // String emailorPhoneNumber;
  String password;
  bool spinner = false;
  final auth = FirebaseAuth.instance;
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
                  'Log In',
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
                },
                decoration: TextFieldDec.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () async{
                      // dbTemp = databaseReference.orderByChild("identifier").equalTo(emailorPhoneNumber);
                      // dbTemp = dbTemp.orderByChild("password").equalTo(password);
                      dbTemp = databaseReference.orderByChild("identifier").equalTo(emailorPhoneNumber).orderByChild("password").equalTo(password);
                      if(dbTemp == null){
                        // Wrong Password
                      }else{
                        databaseReference.child(emailorPhoneNumber).update({
                          'isOnline' : true,
                        });
                        Navigator.pushNamed(context, FindCallsPage.id);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
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

  void verify(){

  }
}
