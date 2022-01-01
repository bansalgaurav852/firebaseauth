// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({Key? key}) : super(key: key);

  @override
  _SigninscreenState createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _phonenoController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  var key = GlobalKey<FormState>();
  bool otpvisiblty = false;
  String verificationID = "";
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //Signin  using google
  Future<UserCredential> signin() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Enter phone no"),
                    controller: _phonenoController,
                    keyboardType: TextInputType.phone,
                  ),
                  Visibility(
                    visible: otpvisiblty,
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: "Enter otp"),
                      controller: _otpController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                      onPressed: () async {
                        if (otpvisiblty) {
                          verifyotp();
                          SharedPreferences locatstorage =
                              await SharedPreferences.getInstance();
                          locatstorage.setString("token", "true");
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const Home();
                          }));
                        } else {
                          loginwithphone();
                        }
                      },
                      label: Text(otpvisiblty ? "verify" : "Signin")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //  google  sign  button
            FloatingActionButton.extended(
                heroTag: "google",
                onPressed: () {
                  signin().then((value) async {
                    SharedPreferences locatstorage =
                        await SharedPreferences.getInstance();
                    locatstorage.setString("token", "true");
                    return Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const Home();
                    }));
                  });
                },
                label: const Text("SignInWithGoogle"))
          ],
        ),
      ),
    );
  }

//  opt verification
  verifyotp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: _otpController.text);
    await firebaseAuth.signInWithCredential(credential);
  }

//  phone entry check and otp sent
  loginwithphone() async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91" + _phonenoController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {}
      },
      codeSent: (String verificationId, int? resettoken) async {
        setState(() {
          otpvisiblty = true;
          verificationID = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(milliseconds: 10000),
    );
  }
}
