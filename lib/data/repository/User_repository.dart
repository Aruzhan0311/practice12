import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository(this._firebaseAuth, this._firestore);

  Future<firebase_auth.UserCredential> signUp(String email, String password, String name, String age) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'age': age,
      'email': email,
    });
    return userCredential;
  }

  Future<firebase_auth.UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}