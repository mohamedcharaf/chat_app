// ignore_for_file: avoid_print, prefer_const_constructors, unused_import

import 'package:chat/firebase/fire_auth.dart';
import 'package:chat/screen/auth/forgot_screen.dart';
import 'package:chat/screen/auth/text_field.dart';
import 'package:chat/screen/setup_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerpassword = TextEditingController();
    TextEditingController controlleremail = TextEditingController();
    final formkey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Welcome Back",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge, // Adjust the font size as needed
            ),
            Text(
              "Material chat app with nabil Al amawi",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge, // Adjust the font size as needed
            ),
            const SizedBox(height: 20),
            Form(
              key: formkey,
              child: Column(children: [
                CustomFild(
                  label_: "email",
                  icon_: const Icon(Icons.email),
                  controller: controlleremail,
                ),

                const SizedBox(height: 20),
                CustomFild(
                  label_: "password",
                  icon_: const Icon(Icons.password),
                  controller: controllerpassword,
                  viewPassword: true,
                ),
                // Add other form fields here if needed
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      child: const Text("Forgot password"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetScreen()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                            await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: controlleremail.text,
                            password: controllerpassword.text)
                        .then((value) => print("***************************done"))
                        .onError(
                          (error, stackTrace) => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text(error.toString()))),
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Center(child: Text("Login".toUpperCase())),
                ),

                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  onPressed: () async {
                    //       Navigator.pushAndRemoveUntil(
                    // context,
                    // MaterialPageRoute(builder: (context) =>  SetupPorfile()),(route) => false);
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: controlleremail.text,
                            password: controllerpassword.text)
                        .then((value) => FireAuth.createUser())
                        .onError(
                          (error, stackTrace) => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text(error.toString()))),
                        );
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Center(
                    child: Text(
                      "Create a count".toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
