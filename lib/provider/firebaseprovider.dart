import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
}