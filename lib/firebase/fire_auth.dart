// ignore_for_file: avoid_print

import 'package:chat/distance/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static User user = auth.currentUser!;

  static Future createUser() async {
   
      ChatUser chatUser = ChatUser(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        about: "Hello, I'm in Nabil's Course",
        image: "",
        createdAt: DateTime.now().toString(),
        lastActivated: DateTime.now().toString(),
        pushToken: "",
        online: false,
      );

      await firebaseFirestore.collection('users').doc(user.uid).set(chatUser.toJson());
  
  }
}
