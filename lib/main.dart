import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livehelp/Screens/LogIn_Screen/login_screen.dart';

import 'Screens/Home_Screen/home_screen.dart';
import 'Screens/testing.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyC3nMDpl31j3cHF6-wlKvX_ZjQMwnpf3OE',
              appId: '1:213683772516:android:74897ab69eb869d5d21371',
              messagingSenderId: '213683772516',
              projectId: 'livehelp-62cf6'))
      : await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Help',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
   home:   FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data == true ? const HomeScreen() : const LogInScreen();
          }
        },
      ),
    );
  }
   Future<bool> _checkLoginStatus() async {
     User? user = _auth.currentUser;
     return user != null;
   }
}
