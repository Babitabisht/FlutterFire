import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutterfire/screens/login.dart';
import 'package:flutterfire/utils/userHelper.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              TextField(
                decoration: InputDecoration(hintText: "password"),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              RaisedButton(
                child: Text("signUp"),
                color: Colors.red,
                textColor: Colors.white,
                elevation: 6.0,
                onPressed: () {
                  debugPrint("SignUp !");
                  debugPrint(
                      "this is email $_email, and this is password $_password");

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((sigedInUser) {
                    debugPrint("authenticated");
  
                    UserHelper().storeNewUser(sigedInUser, context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Login()));
                    debugPrint("success");
                  }).catchError((onError) {
                    debugPrint("----in catch --$onError");
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
