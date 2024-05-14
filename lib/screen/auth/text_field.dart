// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomFild extends StatefulWidget {
  final String label_;
  final TextEditingController controller;
  final Icon icon_;
  bool viewPassword;

 CustomFild({Key? key, required this.label_, required this.controller, required this.icon_,  this.viewPassword = false})
      : super(key: key);

  @override
  State<CustomFild> createState() => _CustomFildState();
}

class _CustomFildState extends State<CustomFild> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        validator: ((value) => value!.isEmpty ? "Required":null),
        obscureText: widget.viewPassword ? obscure:false ,
        controller: widget.controller,
        decoration: InputDecoration(
          // ignore: prefer_const_constructors
          suffixIcon: widget.viewPassword ? IconButton(onPressed: (){
            setState(() {
              obscure =! obscure ;
            });
          }, icon: const Icon(Icons.remove_red_eye)) : const SizedBox(),
          labelText: widget.label_,
          prefixIcon: widget.icon_,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey), // Adjust border color if needed
          ),
        ),
      ),
    );
  }
}
