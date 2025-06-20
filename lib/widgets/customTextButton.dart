import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String action;
  final VoidCallback onTap;
  final double buttonWidth;

  const Custombutton({required this.action,
    required this.onTap,
    required this.buttonWidth,
    Key?key}):super
    (key:key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color.fromARGB(249, 0, 114, 188)),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          action,
          style: TextStyle(color: Color.fromARGB(249, 250, 200, 20), fontSize: 20),
        ),
      ),
    );
  }
}
