// ignore_for_file: unused_import, implementation_imports, unnecessary_import, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:chat/screen/auth/text_field.dart';
import 'package:chat/screen/chat/chat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
 TextEditingController emainCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: () {
        showBottomSheet(
          context: context, builder: (context){
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Row(
                  children: const [
                    Text("enter friend email"),
                  ],
                ),
                CustomFild(label_:"text" , controller: emainCon, icon_: Icon(Icons.abc))
              ],
            ),

          );

        });
        
      },
      child: const Icon(Icons.message),
      ),
      appBar: AppBar(title: const Text("chat"),),
      body:  Padding(padding:  const EdgeInsets.all(20),
       child: Column(
          children: [
             Expanded(

               child:ListView.builder(
                itemCount: 5,
                 itemBuilder: (context,index) {
                   return  const ChatCard();
                 }
               ),
             ),
            // Divider(), // Ajoute une ligne de division entre les éléments de la liste
          ],
        )),
    );
}
}

