// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, unused_local_variable, unused_import, unused_field

import 'dart:async';
import 'dart:io';

import 'package:chat/firebase/FireData.dart';
import 'package:chat/firebase/fire_storage.dart';
import 'package:chat/model/msg_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/chat/chat_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final ChatUser chatUser;
  const ChatScreen({super.key, required this.roomId, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messagesStreamController = StreamController<List<Message>>.broadcast();
  TextEditingController msgCon = TextEditingController();
  final FireData1 fireData1 = FireData1();
  List <String> selectedMsg = [];
  List <String> copyMessage =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatUser.name!),
              Text(
                widget.chatUser.lastActivated!,
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          actions: [

           selectedMsg.isNotEmpty ? IconButton(onPressed: (

            ) {
              FireData1().deletMsg(widget.roomId,selectedMsg );
              
             
            }, icon: const Icon(Icons.delete)) : SizedBox(),
            const SizedBox(
              width: 10,
            ),
          copyMessage.isNotEmpty ?  IconButton(onPressed: () {
            Clipboard.setData(ClipboardData(text: copyMessage.join(" \n ")));
         setState(() {
               copyMessage.clear();
             selectedMsg.clear();
         });
           
          }, icon: const Icon(Icons.copy)): Container()
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(widget.roomId)
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                        'Une erreur s\'est produite : ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator(); // Afficher un indicateur de chargement
                  }
                  final messages = snapshot.data!.docs;

// Mappez les documents de messages vers vos objets Message
                  List<Message> messagesItems = snapshot.data!.docs
                      .map((e) => Message.fromJson(e.data()))
                      .toList()
                    ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                  return messagesItems.isNotEmpty
                      ? ListView.builder(
                          reverse:
                              true, // Afficher les messages les plus récents en bas
                          itemCount: messagesItems.length,
                          itemBuilder: (context, index) {
                            final message = messagesItems[index];
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  if (selectedMsg.length > 0) {
                                     selectedMsg.contains(messagesItems[index].id) ? selectedMsg.remove(messagesItems[index].id) :
                                  selectedMsg.add(messagesItems[index].id!);

                                  };
                                    copyMessage.isNotEmpty? messagesItems[index].type == 'text' ? copyMessage.contains(messagesItems[index].msg) ? copyMessage.remove(messagesItems[index].msg!) : copyMessage.add(messagesItems[index].msg!) : null : null;

                                  
                                });
                              },
                              onLongPress: () {
                                setState(() {
                                  selectedMsg.contains(messagesItems[index].id) ? selectedMsg.remove(messagesItems[index].id) :
                                  selectedMsg.add(messagesItems[index].id!);
                                  print('**********************************');
                                  print(selectedMsg);

                                 messagesItems[index].type == 'text' ? copyMessage.contains(messagesItems[index].msg) ? copyMessage.remove(messagesItems[index].msg!) : copyMessage.add(messagesItems[index].msg!) : null;
                                });
                              },

                              child: ChatMessageCard(
                                selected:  selectedMsg.contains(messagesItems[index].id),
                                messagesItems: message,
                                index: index,
                                roomId: widget.roomId,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: GestureDetector(
                            onTap: () => fireData1.sendMsg(widget.chatUser.id!,
                                'salam Alikom', widget.roomId),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  // mainAxisSize:MainAxisSize.max,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "👋",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      "Say Assalam Alikom",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: msgCon,
                      maxLines: 4,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.sentiment_satisfied)),
                            IconButton(
                                onPressed: () async {
                                  print('Selecting image from gallery...');
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    print('Image selected: ${image.path}');
                                    print(
                                        'File size: ${await File(image.path).length()} bytes');
                                    try {
                                      String? imageUrl = await Future.any([
                                        Firestorage().sendImage(
                                            File(image.path),
                                            widget.roomId,
                                            widget.chatUser.id!),
                                        Future.delayed(Duration(seconds: 60))
                                            .then((_) => throw TimeoutException(
                                                'Upload timeout'))
                                      ]);
                                    } catch (e) {
                                      print('Error during image upload: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Erreur lors de l\'envoi de l\'image: $e')));
                                    }
                                  } else {
                                    print('No image selected');
                                  }
                                },
                                icon: const Icon(Icons.image)),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: "Message",
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (msgCon.text.isNotEmpty) {
                        FireData1()
                            .sendMsg(
                                widget.chatUser.id!, msgCon.text, widget.roomId)
                            .then((value) {
                          setState(() {
                            msgCon.text = "";
                          });
                        });
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            )
          ],
        ));
  }
}
