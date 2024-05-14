import 'package:chat/firebase/fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';
import 'auth/text_field.dart';

class SetupPorfile extends StatefulWidget {
  const SetupPorfile({Key? key}) : super(key: key);

  @override
  State<SetupPorfile> createState() => _SetupPorfileState();
}

class _SetupPorfileState extends State<SetupPorfile> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
       
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Please enter your name',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
            CustomFild(
                label_: 'Name',
                icon_: const Icon(Icons.person),
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
               
  onPressed: () async {
    if (_nameController.text.isEmpty) {
      await FireAuth.createUser();
    }
  },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Center(child: Text('CONTINUE')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}