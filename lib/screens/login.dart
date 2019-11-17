import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/screens/home.dart';
import 'package:flutterfire/screens/signUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text("Login"),
                color: Colors.blueAccent,
                textColor: Colors.white,
                elevation: 6.0,
                onPressed: () {
                  debugPrint("Login !");
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((user) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).catchError((onError) {
                    debugPrint(onError);
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
