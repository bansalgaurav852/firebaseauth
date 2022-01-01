import 'package:firebase/screens/Home.dart';
import 'package:firebase/screens/Signinscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authstate extends StatefulWidget {
  const Authstate({Key? key}) : super(key: key);

  @override
  _AuthstateState createState() => _AuthstateState();
}

class _AuthstateState extends State<Authstate> {
  Future<bool> _checkifloggedin() async {
    Firebase.initializeApp();
    SharedPreferences locatstorage = await SharedPreferences.getInstance();
    var token = locatstorage.get("token");
    if (token.toString() == "true") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    return FutureBuilder(
        future: _checkifloggedin(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              child = const Home();
            } else {
              child = const Signinscreen();
            }
          } else {
            child = const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            body: child,
          );
        });
  }
}
