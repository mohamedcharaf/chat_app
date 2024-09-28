import 'package:chat/model/groupe_model.dart';
import 'package:chat/model/msg_model.dart';
import 'package:chat/screen/chat/group_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../firebase/FireData.dart';
import 'group_member.dart';

class GroupScreen2 extends StatefulWidget {
  final GroupRoom chatGroup;
  const GroupScreen2({super.key, required this.chatGroup});

  @override
  State<GroupScreen2> createState() => _GroupScreen2State();
}

class _GroupScreen2State extends State<GroupScreen2> {
  TextEditingController msgCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Group UAT"),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').where('id', whereIn: widget.chatGroup.members).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List membersName = [];
                  for (var element in snapshot.data!.docs){
                    membersName.add(element.data()['name']);
                  }
                   return Text(
                  membersName.join(', '),
                  style: Theme.of(context).textTheme.labelLarge,
                );
                

                }return Container();
               
              }
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  GroupMember(chatgroup: widget.chatGroup,)));
            },
            icon: const Icon(Icons.person)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(widget.chatGroup.id)
                  .collection('messages')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Message> msgs = snapshot.data!.docs
                      .map((e) => Message.fromJson(e.data()))
                      .toList()
                    ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                  if (msgs.isEmpty) {
                    return Center(
                      child: GestureDetector(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
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
                  } else {
                    return ListView.builder(
                      reverse: true,
                      itemCount: msgs.length,
                      itemBuilder: (context, index) {
                        return GroupMessageCard(
                          index: index, message: msgs[index],
                        );
                      }
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                            icon: const Icon(Icons.sentiment_satisfied)
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image)
                          ),
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
                  if(msgCon.text.isNotEmpty){
                    FireData1().sendGMsg(msgCon.text, widget.chatGroup.id).then((value){
                      setState(() {
                        msgCon.text = "";
                      });
                    });
                  }
                },
                icon: const Icon(Icons.send),
              )
            ],
          )
        ],
      )
    );
  }
}