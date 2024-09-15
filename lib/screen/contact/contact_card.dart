import 'package:chat/firebase/FireData.dart';
import 'package:chat/screen/chat/char_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class ContactCard extends StatelessWidget {
  final ChatUser user;
  const ContactCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: CircleAvatar(),
          title: Text(user.name!),
          subtitle: Text(
            user.about!,
            maxLines: 1,
          ),
          trailing: IconButton(
            onPressed: (() {
              List<String> members = [
                user.id!,
                FirebaseAuth.instance.currentUser!.uid
              ]..sort((a, b) => a.compareTo(b));
              FireData1().createRoom(user.email!).then((value) =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            roomId: members.toString(),
                            chatUser: user,
                          )
                          
                          )
                          ) );
             
            }),
            icon: const Icon(Icons.message),
          )),
    );
  }
}
