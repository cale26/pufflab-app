import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        bool profileExists = await checkProfileExists(user);
        if (!profileExists) {
          // Navigate to CreateProfileAccount page
          // You'll need to implement this navigation in your UI
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        bool profileExists = await checkProfileExists(user);
        if (!profileExists) {
          // Navigate to CreateProfileAccount page
          // You'll need to implement this navigation in your UI
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> checkProfileExists(User user) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('CustomerAccount')
        .doc(user.uid)
        .get();
    return docSnapshot.exists;
  }
}
