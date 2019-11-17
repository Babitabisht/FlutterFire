import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:flutterfire/screens/home.dart';
import 'package:flutterfire/screens/login.dart';

class UserHelper {
  storeNewUser(user, context) {
    print("user is ${user.user.providerData[0]}");
    Firestore.instance.collection("/users").add({
      "email": user.user.providerData[0].email,
      "uid": user.user.providerData[0].uid
    }).then((status) {
      print("Collection created successfuly $status");
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }).catchError((err) {
      print("err in creating collection----$err");
    });
  }
}
