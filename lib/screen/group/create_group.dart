// import 'package:chat/model/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:chat/firebase/FireData.dart';

// class CreateGroupScreen extends StatefulWidget {
//   @override
//   _CreateGroupScreenState createState() => _CreateGroupScreenState();
// }

// class _CreateGroupScreenState extends State<CreateGroupScreen> {
//   TextEditingController gNameCon = TextEditingController();

//   List<String> members = [

//   ];
//   List myContact =[];

//   List<bool> checkedList = [];

//   @override
//   void initState() {
//     super.initState();
//     checkedList = List.generate(members.length, (_) => false);
//   }

//   int get selectedCount => checkedList.where((isChecked) => isChecked).length;

//   bool get canCreateGroup => selectedCount >= 2 && gNameCon.text.isNotEmpty;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create Group"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/placeholder_image.jpg'),
//                   radius: 30,
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: TextField(
//                     controller: gNameCon,
//                     decoration: InputDecoration(
//                       labelText: 'Group Name',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (_) => setState(() {}),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             Text(
//               'Group Members',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//              child:   StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(FirebaseAuth.instance.currentUser!.uid)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     myContact = snapshot.data!.data()!['my_users'];
//                     if (snapshot.hasData) {
                      
//                       return StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('users')
//                               .where('id', whereIn: myContact.isNotEmpty ? myContact : [''])
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               final List<ChatUser> items = snapshot.data!.docs
//                                   .map((e) => ChatUser.fromJson(
//                                       e.data() as Map<String, dynamic>))
//                                      .where((element) => element.id != FirebaseAuth.instance.currentUser!.uid).toList()
//                                    ;
//                               return ListView.builder(
//                                   itemCount: items.length,
//                                   itemBuilder: ((context, index) {
//                                     return CheckboxListTile( checkboxShape: CircleBorder(), title: Text(items[index].name!),  value: true, onChanged: (value){}) ;
//                                   }
//                                   )
//                                   );
//                             } else
//                               return Center(child: CircularProgressIndicator());
//                           }
//                           );
//                     } else
//                       return Container();
//                   }),
//             ),
//             SizedBox(height: 30),
//             if (canCreateGroup)
//               ElevatedButton(
//                 onPressed: createGroup,
//                 child: Text('Create Group'),
//                 style: ElevatedButton.styleFrom(
            
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void createGroup() {
//     List<String> selectedMembers = getSelectedMembers();
//     FireData1().creatGroup(gNameCon.text, selectedMembers);
//     // Ajoutez ici la logique pour naviguer vers l'écran suivant ou afficher un message de confirmation
//   }

//   List<String> getSelectedMembers() {
//     return [
//       for (int i = 0; i < members.length; i++)
//         if (checkedList[i]) members[i]
//     ];
//   }
// }