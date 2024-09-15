import 'package:chat/firebase/FireData.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/auth/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen2 extends StatefulWidget {
  const CreateGroupScreen2({super.key});

  @override
  State<CreateGroupScreen2> createState() => _CreateGroupScreen2State();
}

class _CreateGroupScreen2State extends State<CreateGroupScreen2> {
  TextEditingController gNameCon1 = TextEditingController();
  List<String> members = [];
  List myContact = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group"),
      ),
      floatingActionButton: members.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                // TODO: Implement group creation logic
                 FireData1().creatGroup(gNameCon1.text, members).then((value){
                  Navigator.pop(context);
                  setState(() {
                    members = [];
                    
                  });
                   
                 });
              },
              label: const Text("Create Group"),
              icon: const Icon(Icons.check),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(radius: 40),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            // TODO: Implement photo selection logic
                          },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomFild(
                    label_: "Group name",
                    controller: gNameCon1,
                    icon_: const Icon(Icons.group),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Members'),
                const Spacer(),
                Text("${members.length}"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    myContact = snapshot.data!.data()!['my_users'];
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('id', whereIn: myContact.isNotEmpty ? myContact : [''])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<ChatUser> items = snapshot.data!.docs
                              .map((e) => ChatUser.fromJson(e.data() as Map<String, dynamic>))
                              .where((element) => element.id != FirebaseAuth.instance.currentUser!.uid)
                              .toList();
                          return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: ((context, index) {
                              return CheckboxListTile(
                                checkboxShape: const CircleBorder(),
                                title: Text(items[index].name!),
                                value: members.contains(items[index].id),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      members.add(items[index].id!);
                                    } else {
                                      members.remove(items[index].id!);
                                    }
                                  });
                                },
                              );
                            }),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}