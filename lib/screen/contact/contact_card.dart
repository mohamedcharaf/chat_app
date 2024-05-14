import 'package:flutter/material.dart';


class ContactCard extends StatefulWidget {
  const ContactCard({super.key});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text("Name"),
        trailing: IconButton(onPressed: (() {
          
        }),icon: const Icon(Icons.message),)
      ),

    );
  }
}