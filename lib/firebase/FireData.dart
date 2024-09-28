// ignore_for_file: unused_local_variable

import 'package:chat/model/msg_model.dart';
import 'package:chat/model/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../model/groupe_model.dart';

class FireData1 {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? myUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> createRoom(String email) async {
    if (myUid == null) {
      // Gérer le cas où l'utilisateur actuel n'est pas disponible
      return;
    }
    // Recherche de l'utilisateur par e-mail dans la collection 'users'
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Récupération de l'ID de l'utilisateur
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myUid!, userId]..sort((a, b) => a.compareTo(b));

      QuerySnapshot roomExist = await firestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();
      // Création d'une instance de ChatRoom
      if (roomExist.docs.isEmpty) {
        ChatRoom chatRoom = ChatRoom(
          id: members.toString(), // Utilisation d'un ID plus lisible
          lastMessage: '',
          members: members,
          createdAt: DateTime.now()
              .toIso8601String(), // Initialisation avec la date actuelle
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        // Ajout de la salle de discussion à la collection 'rooms' dans Firestore
        await firestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoom.toJson());
      }
    }
  }

  Future sendMsg(String uid, String msg, String roomId, {String? type}) async {
    String msgId = Uuid().v1();
    Message message = Message(
        id: msgId,
        roomId: roomId,
        createdAt: DateTime.now().toString(),
        fromId: myUid,
        msg: msg,
        read: '',
        toId: uid,
        type: type ?? 'text');
    final messagesSnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .get();
    try {
      // Ajouter le nouveau message à la collection 'messages'
      await FirebaseFirestore.instance
          .collection('rooms/$roomId/messages')
          .doc(msgId)
          .set(message.toJson());
      firestore.collection('rooms').doc(roomId).update({
        'lastMessage': msg,
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch.toString()
      });
    } catch (e) {
      print('Erreur lors de lenvoi du message : $e');
    }
  }

  Future sendGMsg(String msg, String groupId, {String? type}) async {
    String msgId = Uuid().v1();
    Message message = Message(
        id: msgId,
        roomId: groupId,
        createdAt: DateTime.now().toString(),
        fromId: myUid,
        msg: msg,
        read: '',
        toId: '',
        type: type ?? 'text');
    final messagesSnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .get();
    try {
      // Ajouter le nouveau message à la collection 'messages'
      await FirebaseFirestore.instance
          .collection('groups/$groupId/messages')
          .doc(msgId)
          .set(message.toJson());
      firestore.collection('groups').doc(groupId).update({
        'lastMessage': msg,
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch.toString()
      });
    } catch (e) {
      print('Erreur lors de lenvoi du message : $e');
    }
  }

  Future addContact(String email) async {
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;

      await firestore.collection('users').doc(myUid).update({
        'my_users': FieldValue.arrayUnion([userId])
      });
    }
  }

  Future readMessage(String roomId, String msgId) async {
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  deletMsg(String roomId, List<String> msgs) async {
    if (msgs.length == 1) {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(msgs.first)
          .delete();
    } else {
      for (var element in msgs) {
        await firestore
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(element)
            .delete();
      }
    }
  }

  copyMsg(String roomId, List<String> msgs) async {
    for (var element in msgs) {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(element);
    }
  }

  Future creatGroup(String name, List members) async {
    String gId = Uuid().v1();
    members.add(myUid);
    GroupRoom chatGroup = GroupRoom(
        id: gId,
        name: name,
        image: '',
        members: members,
        lastMessage: '',
        lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        admin: [myUid]);
    await firestore.collection('groups').doc(gId).set(chatGroup.toJson());
  }

  Future editGroup(String gId,String name,List members)async{
    await firestore.collection('groups').doc(gId).update({
      'name':name ,
      'members':FieldValue.arrayUnion(members)

    });


  }
 Future removeMember(String gId, String memberId) async {
  await firestore.collection('groups').doc(gId).update({
    'admin': FieldValue.arrayRemove([memberId])
  });
}

 Future promptAdmin(String gId, String memberId) async {
  await firestore.collection('groups').doc(gId).update({
    'admin': FieldValue.arrayUnion([memberId])
  });
}

 Future removeAdmin(String gId, String memberId) async {
  await firestore.collection('groups').doc(gId).update({
    'members': FieldValue.arrayRemove([memberId])
  });
}
}
