import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'Acceuil.dart';

class Auth {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final auth = FirebaseAuth.instance;
  final Storage =new FlutterSecureStorage();

  void loginUser(context)async{
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text).then((value) =>
      {
        Storage.write(key: "user", value: auth.currentUser.toString()),
        print('User logged in'),
        print(Storage.read(key: "user")),
      Navigator.pushReplacementNamed(context, '/acueil'),
      },
      );
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Message d'erreur"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  void registerUser(context)async{
    try {
      await auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) =>
          {
            print('User has registered'),
            Navigator.pushReplacementNamed(context, '/acueil'),
          }
      );
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Message d'erreur"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }
}