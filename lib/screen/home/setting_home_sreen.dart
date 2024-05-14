// ignore_for_file: unnecessary_import, implementation_imports, unused_import, prefer_const_constructors, duplicate_ignore

import 'package:chat/screen/setting/profile.dart';
import 'package:chat/screen/setting/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
       appBar: AppBar(title:  Text("Setting"),),
     body:   Padding(padding:  EdgeInsets.all(20),
     child: Column(
       children:  [

        // ignore: prefer_const_constructors
        ListTile( minVerticalPadding: 40,
              leading:CircleAvatar(
                radius: 30,
              ),
              title: Text("Name"),
              trailing: IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrCode()));
                
              },icon: Icon(Icons.qr_code_scanner),),
              ),


Card(
  child: ListTile(
    title: Text("Profile"),
    leading: Icon(Icons.person),
    trailing: Icon(Icons.arrow_right),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    },
  ),
),
               Card(
            child: ListTile(
              onTap: () {
                showDialog(context: context, builder: ((context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: Colors.red,
                        onColorChanged: (value) {
                          
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(onPressed:() {Navigator.pop(context);}, child: Text("Done"))
                    ],
                  );
               
                  
                }
                
                ),
                );


              },
            title: Text("Theme"),
            leading: Icon(Icons.menu),

    
                   ),
          ),
              Card(
            child: ListTile(
            title: const Text("Profile"),
            leading: const Icon(Icons.person),
            trailing:Switch(value: true, onChanged:(value) {
              
            },
          ),)
                   ),
         
          
     Card(
            child: ListTile(
              onTap: () => FirebaseAuth.instance.signOut() ,
            title: Text("SIGN OUT "),
           
            trailing: Icon(Icons.arrow_back),
                   ),
          ),
       ],
     )
     
     ),
      
    );
  }
}