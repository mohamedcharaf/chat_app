// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_const_constructors

import 'package:chat/screen/auth/text_field.dart';
import 'package:chat/screen/contact/contact_card.dart';
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
  bool searched = false;
  TextEditingController emainCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          icon_: Icon(Icons.abc))
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.contact_page),
      ),
      appBar: AppBar(
  actions: [

    searched ? IconButton(onPressed: (){
      setState(() {
        searched = false ;
      });
    }, icon: Icon(Icons.close)): IconButton(onPressed: (){
      setState(() {
        searched = true ;
      });
    }, icon: Icon(Icons.search)),

  
  ],
  title:   searched
        ? Expanded(
            child: TextField(
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
                child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: ((context, index) {
                      return ContactCard();
                    }))),
          ],
        ),
      ),
    );
  }
}
