import 'package:financial_calculator/auth/login.dart';
import 'package:financial_calculator/widgets/passwordInput.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:financial_calculator/auth/auth_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Move controllers inside the State class
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6; // Firebase minimum requirement
  }

  String? _validateInputs() {
    if (_emailController.text.trim().isEmpty) {
      return 'Please enter your email';
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      return 'Please enter a valid email address';
    }

    if (_passwordController.text.isEmpty) {
      return 'Please enter a password';
    }

    if (!_isValidPassword(_passwordController.text)) {
      return 'Password must be at least 6 characters long';
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> _createUserWithEmailAndPassword() async {
    String? validationError = _validateInputs();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });
    String? result = await _authServices.signup(
        email: _emailController.text,
        password: _passwordController.text,
        name: _fullNameController.text);
    setState(() {
      _isLoading = false;
    });
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful, Login now")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Loginscreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signup failed: $result')));
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                  Inputfield(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  Inputfield(
                    controller: _emailController,
                    hintText: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  Custompwdinput(
                    controller: _passwordController,
                    hintText: 'Password (min 6 characters)',
                  ),
                  const SizedBox(height: 20),
                  Custompwdinput(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                  ),
                  const SizedBox(height: 20),
                  Custombutton(
                    action: _isLoading ? 'Creating Account...' : 'Signup',
                    onTap: _createUserWithEmailAndPassword,
                    buttonWidth: buttonWidth,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/loginScreen');
                          },
                          child: const Text("Login"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
