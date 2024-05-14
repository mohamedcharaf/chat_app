// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCon = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameCon.text = "Myname";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 70,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person_add),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                  title: TextField(
                    controller: nameCon,
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        // InputBorder:
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person_add),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                  title: TextField(
                    controller: nameCon,
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: "About",
                        // InputBorder:
                        border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                  title: const Text("email"),
                  subtitle: const Text("charaf@gmail.com"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                  title: const Text("Joined On"),
                  subtitle: const Text("20240512"),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    "Save".toUpperCase(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
