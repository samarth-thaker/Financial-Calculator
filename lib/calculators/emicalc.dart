import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({Key? key}) : super(key: key);

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _principalController = TextEditingController();

  double _emi = 0.0;

  double monthlyInstallment(
      double principalAmount, double annualInterestRate, int years) {
    double r = annualInterestRate / 1200;
    int n = years * 12;
    return (principalAmount * r * pow((1 + r), years * 12)) /
        (pow((1 + r), n) - 1);
  }

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _emi = monthlyInstallment(principal, annualInterestRate, years);
    });
  }

  void reset() {
    _principalController.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _emi = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(title: const Text("EMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Inputfield(
              controller: _principalController,
              hintText: "Loan amount (in Rs.)",
            ),
            const SizedBox(height: 30),
            Inputfield(
              controller: _annualInterestRateController,
              hintText: "Rate of interest (in % p.a)",
            ),
            const SizedBox(height: 30),
            Inputfield(
              controller: _yearsController,
              hintText: "Time period (upto 50 years)",
            ),
            const SizedBox(height: 30),
            Custombutton(
                action: 'Calculate EMI',
                onTap: _calculate,
                buttonWidth: buttonWidth),
            const SizedBox(height: 30),
            Custombutton(
                action: 'Reset', onTap: reset, buttonWidth: buttonWidth),
            const SizedBox(height: 30),
            Text('EMI: Rs. ${_emi.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
          ],
        ))),
      ),
    );
  }
}
