// ignore_for_file: unnecessary_null_comparison

import 'package:chat/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuth {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future createUser(User user) async {
    if (user == null) {
      throw Exception('User is null');
    }

    try {
      final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        about: "Hello, I'm in Nabil's Course",
        image: null, // Utiliser null au lieu d'une chaîne vide
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
        pushToken: null, // Utiliser null au lieu d'une chaîne vide
        online: false, myUsers: [],
      );

      await _firestore.collection('users').doc(user.uid).set(chatUser.toJson());
    } catch (e) {
      // Gérer les erreurs liées à l'écriture dans Firestore
      print('Error creating user: $e');
      rethrow;
    }
  }
}