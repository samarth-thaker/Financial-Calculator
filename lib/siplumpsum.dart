import 'package:flutter/material.dart';
import 'dart:math';

class Lumpsumscreen extends StatefulWidget {
  const Lumpsumscreen({Key? key}) : super(key: key);

  @override
  State<Lumpsumscreen> createState() => _LumpsumscreenState();
}

class _LumpsumscreenState extends State<Lumpsumscreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _maturityValue = 0.0;

  double calculateLumpsumMaturity(
      double p, double annualInterestRate, int years) {
    double maturityValue = p * pow((1 + annualInterestRate / 100), years);
    return maturityValue;
  }

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _maturityValue =
          calculateLumpsumMaturity(principal, annualInterestRate, years);
    });
  }

  void reset() {
    (_principalController.clear());
    (_annualInterestRateController.clear());
    (_yearsController.clear());
    setState(() {
      _maturityValue = 0.0;
    });
  }

  Widget customTextButton(String action, VoidCallback onTap, double buttonWidth, {double width = 150.0}) {
    return Container(
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; // Adjust button width as 80% of screen width

    return Scaffold(
      appBar: AppBar(title: const Text("Lumpsum SIP Calculator")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _principalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Lumpsum deposit amount (in Rs.)",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _annualInterestRateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Expected return (in % p.a)",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _yearsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Time period (upto 50 years)",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            customTextButton("Calculate my wealth", _calculate,  buttonWidth),
            const SizedBox(height: 30),
            customTextButton('Reset', reset, buttonWidth),
            const SizedBox(height: 30),
            Text('Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
          ],
        ),
      ),
 
        ),
      ) 
          );
  }
}
