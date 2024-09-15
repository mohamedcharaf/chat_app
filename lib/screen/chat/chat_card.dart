// ignore_for_file: unused_import, unnecessary_import, implementation_imports

import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;
import 'package:chat/model/msg_model.dart';
import 'package:chat/model/room_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/chat/char_screen.dart';
import 'package:chat/screen/setup_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../home/chat_home_screen.dart';

class ChatCard extends StatelessWidget {
  final ChatRoom items;
  // final ChatUser chatUser_ ;
  const ChatCard({
    Key? key,
    required chatRoom,
    required this.items,
    //  required this.chatUser_,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
   List<dynamic> members = items.members ?? []; // Assurez-vous que `members` est une liste
String userId = members.isNotEmpty
    ? members.firstWhere(
        (element) => element != FirebaseAuth.instance.currentUser!.uid,
        orElse: () => FirebaseAuth.instance.currentUser!.uid)
    : FirebaseAuth.instance.currentUser!.uid;

   
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ChatUser chatUser_ = ChatUser.fromJson(snapshot.data!.data()!);
          return Card(
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            chatUser: chatUser_,
                            roomId: items.id!,
                          ))),
              leading: const CircleAvatar(),
              title: Text(chatUser_.name!),
              subtitle: Text(items.lastMessage! == ""
                  ? chatUser_.about!:items.lastMessage!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                   ),
          trailing: StreamBuilder(
  stream: FirebaseFirestore.instance.collection('rooms').doc(items.id).collection('messages').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final unReadList = snapshot.data!.docs.map((e) => Message.fromJson(e.data())).where((element) => element.read == "").where((element)=>element.fromId != FirebaseAuth.instance.currentUser!.uid );
      return unReadList.isNotEmpty 
        ? badges.Badge(
            badgeContent: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(unReadList.length.toString()),
            ),
          )
        : Text(
              DateFormat('MM/dd/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                  int.parse(items.lastMessageTime.toString()),
                )));
    } else {
      return Text(items.lastMessageTime.toString());
    }
  },
)

            )   
          );
        } else {
          return const Text("data");
        }
      },
    );
  }
}
