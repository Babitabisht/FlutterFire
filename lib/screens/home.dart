import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/screens/login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Welcome you are at home"),
            RaisedButton(
              color: Colors.red,
              child: Text("Logout"),
              textColor: Colors.white,
              onPressed: () {
                FirebaseAuth.instance.signOut().then((onValue) {
                  debugPrint("---in logout----");
                 // print(onValue);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }).catchError((onError) {
                  debugPrint("---error on logout-----$onError");
                  
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
