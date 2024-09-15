// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/screen/auth/text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => ForgetScreenState();
}

class ForgetScreenState extends State<ForgetScreen> {
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controlleremail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge, // Adjust the font size as needed
              ),
              Text(
                "Please enter your email",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium, // Adjust the font size as needed
              ),
              const SizedBox(height: 20),
              CustomFild(
                label_: "email",
                icon_: const Icon(Icons.email),
                controller: controlleremail,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: controlleremail.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email sent. Check your email."),
                      ),
                    );
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(child: Text("Send email".toUpperCase())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
