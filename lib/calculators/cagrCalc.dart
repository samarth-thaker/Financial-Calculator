import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class Cagrscreen extends StatefulWidget {
  const Cagrscreen({Key? key}) : super(key: key);

  @override
  State<Cagrscreen> createState() => _CagrscreenState();
}

class _CagrscreenState extends State<Cagrscreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  //final TextEditingController _amountInvestedController = TextEditingController();

  double _overallGrowth = 0.0;
  /* double _amountInvested = 0.0;
  double _earnings = 0.0; */

  double calculateCAGR(double i, double f, int years) {
    /*  double monthlyRate =
        (annualInterestRate / 100) / 12; */ // Monthly interest rate
    /* int months = years * 12;  */ // Total number of months

    double per = pow(f / i, 1 / years) - 1;
    return per * 100;
  }

  

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  /* double amountEarned(
      double p, double annualInterestRate, int years) {
    return calculateLumpsumMaturity(p, annualInterestRate, years) - p;
  } */

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _overallGrowth = calculateCAGR(principal, annualInterestRate, years);
      /* _amountInvested =
          investedAmount(monthlyInvestment, annualInterestRate, years);
      _earnings = amountEarned(monthlyInvestment, annualInterestRate, years); */
    });
  }

  void reset() {
    _principalController.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _overallGrowth = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("CAGR Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Inputfield(
                  controller: _principalController,
                  hintText: "Initial investment (in Rs.)"),
              const SizedBox(height: 30),
              Inputfield(
                controller: _annualInterestRateController,
                hintText: "Final investment (in Rs.)",
              ),
              const SizedBox(height: 30),
              Inputfield(
                controller: _yearsController,
                hintText: "Time period (upto 50 years)",
              ),
              const SizedBox(height: 30),
              Custombutton(action:'Calculate CAGR ',onTap:  _calculate, buttonWidth:buttonWidth),
              const SizedBox(height: 30),
              Custombutton(action:'Reset',onTap:  reset, buttonWidth:buttonWidth),
              const SizedBox(height: 30),
              Text('CAGR: ${_overallGrowth.toStringAsFixed(2)}%'),
              const SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }
}
