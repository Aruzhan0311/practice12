import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/domain/entities/user_entities.dart';

class FirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    await _firestore.collection('users').doc(user.email).set(user.toJson());
  }
}