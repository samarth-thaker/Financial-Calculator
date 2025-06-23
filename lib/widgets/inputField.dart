import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  const Inputfield({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
     decoration: InputDecoration(
          hintText: hintText, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
  ),
  );
    
  /* return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(0),
        ),     fillColor: Colors.black,filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never),
    ); */
}
