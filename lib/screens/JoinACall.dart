import 'dart:io' show Platform;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hackathonapp/main.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'LoginScreen.dart';

class FindCallsPage extends StatefulWidget {
  static const String id = 'screen4';

  @override
  _FindCallsPageState createState() => _FindCallsPageState();
}
class _FindCallsPageState extends State<FindCallsPage> {
  //Add new variables here for variables only nessesary on this page
  final databaseReference = FirebaseDatabase.instance.reference();
  String volunteer;
  // String volunteerIdentifier;
  String otherperson;
  String otherpersonIdentifier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Join A Call With Someone else'),
      ),
      body: Center(//positioning of buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //spacing of widgets in column
          children: [//widgets in this column of widgets
            RaisedButton(//volunteer button
              elevation: 10.0,
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0),
              child: Text(
                'Volunteer',
                style: TextStyle(//what the text will look like
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.red,

              onPressed: () async{
                volunteer = databaseReference.orderByChild('isVolunteer').equalTo(true) as String;

                // volunteerIdentifier = volunteer.orderByChild('isOnline').equalTo(true); // grab the identifier of the volunteer
                databaseReference.child(emailorPhoneNumber).update({ //emailorPhonenumber
                  'wantsToTalkToVolunteer' : true,
                  'person' : volunteer,
                  'isOnline' : false
                });

                databaseReference.child(volunteer).update({
                  'wantsToTalkToVolunteer' : true,
                  'person' : emailorPhoneNumber,
                  'isOnline' : false
                });
                 Future<Object> _obj ()async {
                  Object _objdatabase;
                 await databaseReference.child(otherpersonIdentifier).once().then((DataSnapshot snapshot){
    // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                String url = 'https://zoom.us/j/5268729266?pwd=ZlRvZGxDWE9SY1laZ0NwVWVnLzNNUT09'; // grab the link of the volunteer

                if ( canLaunch(url) != null) {
                   launch(url, forceWebView: true);
                  // redirect to home
                } else {
                  throw 'Could not launch $url. Try Again';
                }
                //Volunteer Button
                //what is going to happen when This button is pressed
              },
    };
            ),
            RaisedButton(//the another person button
              child: Text(
                'Another Person',
                style: TextStyle(//what the text will look like
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.green,
              onPressed: () async{
                bool temp = false;
                otherperson = databaseReference.orderByChild('isOnline').equalTo(true) as String; // grab one other person online

                if(otherperson != null){ // If there are other available people
                  temp = true;

                  databaseReference.child(emailorPhoneNumber).update({
                    'isOnline' : false,
                    'person' : otherpersonIdentifier
                  });

                  databaseReference.child(otherpersonIdentifier).update({
                    'isOnline' : false,
                    'person' : emailorPhoneNumber
                  });
                }else{
                  await (databaseReference.child(emailorPhoneNumber) != null);
                  otherpersonIdentifier = databaseReference.child(emailorPhoneNumber) as String; // grab the value in the person column
                }

                var url;

                if(temp == true){
                  url = databaseReference.child(emailorPhoneNumber); // grab the zoom link
                }else{
                  url = databaseReference.child(otherpersonIdentifier); // grab the zoom link
                }
                if (await canLaunch(url)) {
                  await launch(url, forceWebView: true);
                } else {
                  throw 'Could not launch $url. Try Again';
                }
                //Random Person Button
                //what is going to happen when This button is pressed
              },
              elevation: 10.0,
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0), //Size of the button
            );
            // RaisedButton(//the person in your age group button
            //   child: Text(
            //     'Same Age group',
            //     style: TextStyle(//what the text will look like
            //       color: Colors.white,
            //       fontSize: 20.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   color: Colors.blue,
            //   onPressed: () async{//when button is pressed
            //     const url = 'https://google.com'; //put the skype link in here. In the quotation marks
            //     if (await canLaunch(url)) {
            //       await launch(url, forceWebView: true);
            //     } else {
            //       throw 'Could not launch $url. Try Again';
            //     }
            //     //Same Age Group Button
            //     //what is going to happen when This button is pressed
            //   },
            //   elevation: 10.0,
            //   padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0), //Size of the button
            // ),
          ],
        ),
      ),
    );
  }
}

