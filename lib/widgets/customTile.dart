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
      title: Text(title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(249, 250, 200, 20))),
      leading: Icon(icon, size: 30, color: Color.fromARGB(249, 250, 200, 20)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color.fromARGB(249, 250, 200, 20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: const Color.fromARGB(249, 0, 114, 188),
      onTap: onTap,
    );
  }
}
