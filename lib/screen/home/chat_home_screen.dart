// ignore_for_file: unused_import, unnecessary_cast

import 'package:badges/badges.dart';
import 'package:chat/firebase/FireData.dart';
import 'package:chat/model/room_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/auth/text_field.dart';
import 'package:chat/screen/chat/chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Text("enter friend email"),
                      ],
                    ),
                    CustomFild(
                        label_: "text",
                        controller: emainCon,
                        icon_: const Icon(Icons.abc)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        onPressed: () {
                          if (emainCon.text.isNotEmpty) {
                            FireData1().createRoom(emainCon.text).then((value) {
                              setState(() {
                                emainCon.text = "";
                              });
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Center(
                          child: Text("Create Chat"),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.message),
      ),
      appBar: AppBar(title: const Text("chat")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .where('members',
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  ['id'].first == 'id';
                  if (snapshot.hasData) {
                    List<ChatRoom> items = snapshot.data!.docs
                        .map((e) => ChatRoom.fromJson(e.data()))
                        .toList()
                      ..sort((a, b) =>
                          b.lastMessageTime!.compareTo(a.lastMessageTime!));

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ChatCard(
                          items: items[index],
                          chatRoom: null,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Une erreur s'est produite"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
