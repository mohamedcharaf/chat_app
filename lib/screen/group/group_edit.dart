import 'package:chat/model/groupe_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat/firebase/FireData.dart';

class GroupEdit extends StatefulWidget {
  final GroupRoom chatgroup ;

  const GroupEdit({super.key, required this.chatgroup});
  @override
  _GroupEditState createState() => _GroupEditState();
}

class _GroupEditState extends State<GroupEdit> {
  TextEditingController gNameCon = TextEditingController();


  List members = [];
  List myContact =[];

  List<bool> checkedList = [];

  @override
  void initState() {
    super.initState();
    checkedList = List.generate(members.length, (_) => false);
    gNameCon.text = widget.chatgroup.name ; 
  }

  int get selectedCount => checkedList.where((isChecked) => isChecked).length;

  bool get canCreateGroup => selectedCount >= 2 && gNameCon.text.isNotEmpty;

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Edit Group"),
      backgroundColor: Colors.blue,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/placeholder_image.jpg'),
                radius: 30,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: gNameCon,
                  decoration: const InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Add Members',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<ChatUser>>(
              future: getAvailableContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<ChatUser> availableContacts = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: availableContacts.length,
                  itemBuilder: (context, index) {
                    final user = availableContacts[index];
                    return CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: Text(user.name ?? ''),
                      value: members.contains(user.id),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            members.add(user.id);
                          } else {
                            members.remove(user.id);
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          if (canSaveChanges)
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
        ],
      ),
    ),
  );
}

bool get canSaveChanges => gNameCon.text.isNotEmpty;

void saveChanges() {
  FireData1().editGroup(widget.chatgroup.id, gNameCon.text, members);
  // Add navigation or confirmation message here
}

Future<List<ChatUser>> getAvailableContacts() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return [];

  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.uid)
      .get();
  
  final myContactIds = List<String>.from(userDoc.data()?['my_users'] ?? []);
  
  if (myContactIds.isEmpty) return [];

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', whereIn: myContactIds)
      .get();

  return querySnapshot.docs
      .map((e) => ChatUser.fromJson(e.data()))
      .where((user) => user.id != currentUser.uid && !widget.chatgroup.members.contains(user.id))
      .toList();
}
}