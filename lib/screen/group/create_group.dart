// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController gNameCon = TextEditingController();

  List<String> members = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
  ];

  List<bool> checkedList = [];

  @override
  void initState() {
    super.initState();
    if (members.isNotEmpty) {
      // Initialisation de l'état de chaque case à cocher à false
      for (var i = 0; i < members.length; i++) {
        checkedList.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
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
                CircleAvatar(
                  backgroundImage: AssetImage('assets/placeholder_image.jpg'),
                  radius: 30,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: gNameCon,
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Group Members',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(members[index]),
                    trailing: Checkbox(
                      value: checkedList.isNotEmpty ? checkedList[index] : false,
                      onChanged: (newValue) {
                        setState(() {
                          checkedList[index] = newValue!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: canCreateGroup() ? () {
                // Action à effectuer lorsque le bouton est pressé
                print('Group name: ${gNameCon.text}');
                print('Selected members: ${getSelectedMembers()}');
              } : null,
              child: Text('Create Group'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour obtenir les membres sélectionnés
  List<String> getSelectedMembers() {
    List<String> selectedMembers = [];
    for (var i = 0; i < members.length; i++) {
      if (checkedList.isNotEmpty && checkedList[i]) {
        selectedMembers.add(members[i]);
      }
    }
    return selectedMembers;
  }

  // Méthode pour vérifier si le groupe peut être créé
  bool canCreateGroup() {
    int selectedCount = 0;
    for (var isChecked in checkedList) {
      if (isChecked) {
        selectedCount++;
      }
    }
    return selectedCount >= 2;
  }
}
