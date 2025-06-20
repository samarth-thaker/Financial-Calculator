import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const Inputfield({
    required this.controller,
    required this.hintText,
    Key?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(249, 0, 114, 188),
            ),
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
