// ignore_for_file: unused_import, unnecessary_import, implementation_imports

import 'package:badges/badges.dart';
import 'package:chat/screen/chat/char_screen.dart';
import 'package:chat/screen/setup_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../home/chat_home_screen.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())),
       leading: const CircleAvatar(),
       title: const Text("Name"),
       subtitle: const Text("Last Message"),
       trailing: const Badge(
         
        badgeContent: Padding(
         
          padding: EdgeInsets.symmetric(horizontal:4.0),
          child: Text("3"),
            
        ),            
      
       ),
                ),
    );
  }}