import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  double _overallGrowth = 0.0;

  Future<void> saveCalculation({
    required String type,
    required Map<String, dynamic> inputs,
    required Map<String, dynamic> outputs,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final calcRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('calculations');

    await calcRef.add({
      'type': type,
      'inputs': inputs,
      'outputs': outputs,
    });
  }

  double calculateCAGR(double i, double f, int years) {
    double per = pow(f / i, 1 / years) - 1;
    return per * 100;
  }

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _overallGrowth = calculateCAGR(principal, annualInterestRate, years);
    });
    saveCalculation(type: 'CAGR', inputs: {
      'initialinvestment': principal,
      'time period': years,
    }, outputs: {
      'cagr': _overallGrowth,
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
              Custombutton(
                  action: 'Calculate CAGR ',
                  onTap: _calculate,
                  buttonWidth: buttonWidth),
              const SizedBox(height: 30),
              Custombutton(
                  action: 'Reset', onTap: reset, buttonWidth: buttonWidth),
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
