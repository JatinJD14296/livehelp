import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DatabaseService {
  final DatabaseReference _userRef =
  FirebaseDatabase.instance.reference().child('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
/// SignIn Screen
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String gender,
    required String bloodGroup,
    required String nationality,
    required String mobileNumber,
    required String aadharCard,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("$userCredential");
      String userId = userCredential.user!.uid;
      await _userRef.child(userId).set({
        'name': name,
        'email': email,
        'password': password,
        'address': address,
        'gender': gender,
        'bloodGroup': bloodGroup,
        'nationality': nationality,
        'mobileNumber': mobileNumber,
        'aadharCard': aadharCard,
      });

      log('User added successfully');
    }
    catch (error) {
      log('Failed to add user: $error');
    }
  }
/// LogIn Screen
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (error) {
      log('Failed to log in with email and password: $error');
      return null;
    }
  }
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      log('exception->$e');
    }
  }
  /// LogOut Button
  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
