// import 'package:firebase/screens/Signinscreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GoogleProfile extends StatefulWidget {
//   const GoogleProfile({Key? key}) : super(key: key);

//   @override
//   _GoogleProfileState createState() => _GoogleProfileState();
// }

// class _GoogleProfileState extends State<GoogleProfile> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   void signout() {
//     googleSignIn.signOut().then((value) async {
//       SharedPreferences locatstorage = await SharedPreferences.getInstance();
//       locatstorage.setString("token", "false");
//     });
//   }

//   User? user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundImage: Image.network(user!.photoURL.toString()).image,
//             radius: 70,
//           ),
//           Text("Name:" + user!.displayName.toString()),
//           Text("Email:" + user!.email.toString()),
//           Text("phone number:" + user!.phoneNumber.toString()),
//           FloatingActionButton.extended(
//               onPressed: () {
//                 signout();
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) {
//                   return const Signinscreen();
//                 }));
//               },
//               label: const Text("signout")),
//         ],
//       ),
//     );
//   }
// }
