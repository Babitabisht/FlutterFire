# flutterfire

Firebase functions

\*\*\*Used plugins

- cloud_firestore:
- firebase_auth:
- firebase_core: ^0.4.0+9
- google_sign_in

#### SignIn

```
FirebaseAuth.instance
.createUserWithEmailAndPassword(
 email: _email,
password: _password)
.then((sigedInUser) {
                    debugPrint("authenticated");

                    UserHelper().storeNewUser(sigedInUser, context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Login()));
                    debugPrint("success");
                  }).catchError((onError) {
                    debugPrint("----in catch --$onError");
                  });

```

#### Login with email and password

```

 FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((user) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).catchError((onError) {
                    debugPrint(onError);
                  });


```

#### create collections

```
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
```

### sign in with google

```

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

```
