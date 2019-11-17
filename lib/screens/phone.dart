import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterfire/screens/home.dart';
import 'package:flutterfire/screens/login.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String phoneNo;
  String smsCode;
  String verificationId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> verifyPhone() async {
    debugPrint("----inside----verify phone");

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      debugPrint("---------in autoRetrieve-------$verId");

      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResend]) async {
      debugPrint("---------in smsCodeSent-------$verId");

      this.verificationId = verId;
      smsCodeDialog(context).then((onValue) {
        debugPrint("---signedin---");
      }).catchError((onError) {
        debugPrint("---error--");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (user) {
      debugPrint("----verified----$user");
    };

    final PhoneVerificationFailed verificationFailed = (error) {
      debugPrint(
          "-----verification failed--------$error ${error.code} ${error.message}");
    };

    debugPrint(this.phoneNo);
    debugPrint(this.verificationId);
    debugPrint(this.smsCode);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      timeout: Duration(seconds: 5),
      forceResendingToken: 5,
      verificationCompleted: verifiedSuccess,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authenticate using phone Number"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Verify using phone number"),
          TextField(
            decoration: InputDecoration(hintText: "Enter phone Number"),
            onChanged: (value) {
              this.phoneNo = value;
            },
          ),
          RaisedButton(
            child: Text("verify"),
            textColor: Colors.white,
            color: Colors.blueAccent,
            onPressed: () {
              verifyPhone();
            },
          )
        ],
      )),
    );
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user =
        await _auth.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Enter sms code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text("Done !"),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }
}
