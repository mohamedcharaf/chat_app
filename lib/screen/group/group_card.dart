import 'package:chat/screen/group/group_screen2.dart';
import 'package:flutter/material.dart';

import 'package:chat/model/groupe_model.dart';

class GroupCard extends StatelessWidget {
  final GroupRoom chatGroup;

  const GroupCard({Key? key, required this.chatGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  GroupScreen2(chatGroup: chatGroup,)),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Text(
            chatGroup.name.characters.first.toUpperCase() ,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

        ),
        title: Text(
          chatGroup.name ,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:  Text(
          chatGroup.lastMessage == "" ? 'no msg ' : chatGroup.lastMessage, // Placeholder text, replace with actual last message if available
          style: const TextStyle(color: Colors.grey),
        ),
        
      ),
    );
  }
}