// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_const_constructors, unused_local_variable

import 'package:chat/firebase/FireData.dart';
import 'package:chat/model/user_model.dart';
import 'package:chat/screen/auth/text_field.dart';
import 'package:chat/screen/contact/contact_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool searched = true;
  List MyContact = [];
  TextEditingController emainCon = TextEditingController();

  getMycontact() async {
    final contact = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => MyContact = value.data()!['my_users']);
    print('mycontact');
  }

  @override
  void initState() {
    getMycontact();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: searched ? Row(
      //     children: [Expanded(child: TextField(decoration: InputDecoration(border: InputBorder.none),))],
      //   ) : Text("MY Contatct"),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
              backgroundColor: Colors.teal,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Text("enter friend email"),
                        ],
                      ),
                      CustomFild(
                          label_: "text",
                          controller: emainCon,
                          icon_: Icon(Icons.abc)),
                      ElevatedButton(
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
                            FireData1().addContact(emainCon.text).then((value) {
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
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.contact_page),
      ),
      appBar: AppBar(
        actions: [
          searched
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searched = false;
                      emainCon.text = "" ;
                    });
                  },
                  icon: Icon(Icons.close))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searched = true;
                    });
                  },
                  icon: Icon(Icons.search)),
        ],
        title: searched
            ? Expanded(
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      emainCon.text = value ;

                    });
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search by name",
                    border: InputBorder.none,
                  ),
                ),
              )
            : Text("contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: 
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    MyContact = snapshot.data!.data()!['my_users'];
                    if (snapshot.hasData) {
                      
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('id', whereIn: MyContact.isNotEmpty ? MyContact : [''])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<ChatUser> items = snapshot.data!.docs
                                  .map((e) => ChatUser.fromJson(
                                      e.data() as Map<String, dynamic>)).where((element) => element.name!.toLowerCase().startsWith(emainCon.text.toLowerCase()))
                                  .toList()..sort((a,b)=>a.name!.compareTo(b.name!) );
                              return ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: ((context, index) {
                                    return ContactCard(user: items[index],);
                                  }
                                  )
                                  );
                            } else
                              return Center(child: CircularProgressIndicator());
                          }
                          );
                    } else
                      return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
