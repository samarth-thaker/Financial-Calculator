import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

Future<void> loginUserWithEmailAndPassword(BuildContext context) async {
  try {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
    print(userCredential);
    Navigator.pushNamed(context, '/dashboard');
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}

class _LoginscreenState extends State<Loginscreen> {
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
                    action: 'Login',
                    onTap: () async {
                      await loginUserWithEmailAndPassword(context);
                    },
                    buttonWidth: buttonWidth,
                  ),
                  Row(children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/signupScreen')},
                        child: Text("Signup"))
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
