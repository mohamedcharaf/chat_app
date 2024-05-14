// ignore_for_file: unnecessary_import, implementation_imports, unused_import

import 'package:chat/screen/chat/chat_card.dart';
import 'package:chat/screen/group/group_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GroupHomeScreen extends StatefulWidget {
  const GroupHomeScreen({super.key});

  @override
  State<GroupHomeScreen> createState() => _GroupHomeScreenState();
}

class _GroupHomeScreenState extends State<GroupHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: () {
        showBottomSheet(
          context: context, builder: (context){
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("enter friend email"),
                  ],
                ),
                // CustomFild(label_:"text" , controller: emainCon, icon_: Icon(Icons.abc))
              ],
            ),

          );

        });
        
      },
      child: const Icon(Icons.message),
      ),
      appBar: AppBar(title: const Text("Group"),),
      body:  Padding(padding:  const EdgeInsets.all(20),
       child: Column(
          children: [
             Expanded(

               child:ListView.builder(
                itemCount: 5,
                 itemBuilder: (context,index) {
                   return  const GroupCard();
                 }
               ),
             ),
            // Divider(), // Ajoute une ligne de division entre les éléments de la liste
          ],
        )),
    );
  }
}