import 'package:flutter/material.dart';

class Customtile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const Customtile({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // <-- HIGH CONTRAST
        ),
      ),
      leading: Icon(icon, size: 30, color: Colors.white),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: Colors.deepPurple, // Safer color
      onTap: onTap,
    );
  }
}
