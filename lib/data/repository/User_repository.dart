import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/provider/firebaseprovider.dart';

class UserRepository {
  final FirebaseProvider _firebaseProvider;

  UserRepository(this._firebaseProvider);

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseProvider.signInWithEmailAndPassword(email, password);
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseProvider.createUserWithEmailAndPassword(email, password);
  }
}