// import 'package:firebase/screens/Home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Signinwithphone extends StatefulWidget {
//   const Signinwithphone({Key? key}) : super(key: key);

//   @override
//   _SigninwithphoneState createState() => _SigninwithphoneState();
// }

// class _SigninwithphoneState extends State<Signinwithphone> {
//   String verificationID = "";
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   var key = GlobalKey<FormState>();
//   bool otpvisiblty = false;
//   final TextEditingController _phonenoController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("enter phone no"),
//             TextFormField(
//               controller: _phonenoController,
//               keyboardType: TextInputType.phone,
//             ),
//             Visibility(
//               visible: otpvisiblty,
//               child: TextFormField(
//                 controller: _otpController,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             FloatingActionButton.extended(
//                 onPressed: () async {
//                   if (otpvisiblty) {
//                     verifyotp();
//                     SharedPreferences locatstorage =
//                         await SharedPreferences.getInstance();
//                     locatstorage.setString("token", "true");
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) {
//                       return const Home();
//                     }));
//                   } else {
//                     loginwithphone();
//                   }
//                 },
//                 label: Text(otpvisiblty ? "verify" : "Signin")),
//           ],
//         ),
//       ),
//     );
//   }

//   verifyotp() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: _otpController.text);
//     await firebaseAuth.signInWithCredential(credential).then((value) {});
//   }

//   loginwithphone() async {
//     await firebaseAuth.verifyPhoneNumber(
//       phoneNumber: "+91" + _phonenoController.text,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await firebaseAuth
//             .signInWithCredential(credential)
//             .then((value) => print("Signed  In  successfully"));
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == "invalid-phone-number") {
//           print("numbernotvalid");
//         }
//       },
//       codeSent: (String verificationId, int? resettoken) async {
//         setState(() {
//           otpvisiblty = true;
//           verificationID = verificationId;
//         });

//         print("Success");
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//       timeout: const Duration(milliseconds: 10000),
//     );
//   }
// }
