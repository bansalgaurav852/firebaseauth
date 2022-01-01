import 'package:firebase/screens/Signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signout() {
    googleSignIn.signOut().then((value) async {});
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // print(user);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Succesfully loggedin"),
            FloatingActionButton.extended(
                onPressed: () async {
                  await googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut().then((value) async {
                    SharedPreferences locatstorage =
                        await SharedPreferences.getInstance();
                    locatstorage.setString("token", "false");
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const Signinscreen();
                  }));
                },
                label: const Text("signout")),
          ],
        ),
      ),
    );
  }
}
