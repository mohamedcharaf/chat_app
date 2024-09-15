// ignore_for_file: unnecessary_import, implementation_imports, unused_import

import 'package:chat/model/groupe_model.dart';
import 'package:chat/screen/chat/chat_card.dart';
import 'package:chat/screen/group/create_group.dart';
import 'package:chat/screen/group/create_group2.dart';
import 'package:chat/screen/group/group_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
       Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateGroupScreen2()) );
        
      },
      child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Group"),),
      body:  Padding(padding:  const EdgeInsets.all(20),
       child: Column(
          children: [
             Expanded(

               child:StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('groups').where('members',arrayContains: FirebaseAuth.instance.currentUser!.uid  ).snapshots(),
                 builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<GroupRoom> items = snapshot.data!.docs .map((e) => GroupRoom.fromJson(e.data())).toList()..sort((a,b)=>b.lastMessageTime.compareTo(a.lastMessageTime));
                     return ListView.builder(
                    
                    itemCount: items.length,
                     itemBuilder: (context,index) {
                       return   GroupCard(chatGroup: items[index],);
                     }
                   );

                  }else{
                    return Container();
                  }
                  
                 }
               ),
             ),
            
          ],
        )),
    );
  }
}