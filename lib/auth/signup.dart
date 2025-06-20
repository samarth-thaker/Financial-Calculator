import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

Future<void> createUserWithEmailAndPassword() async {
  try {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Custombutton(
                    action: 'Signup',
                    onTap: () async {
                      await createUserWithEmailAndPassword();
                    },
                    buttonWidth: buttonWidth,
                  ),
                  Row(children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/loginScreen')},
                        child: Text("Login"))
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}