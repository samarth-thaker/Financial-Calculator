import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Goallumpsum extends StatefulWidget {
  const Goallumpsum({Key? key}) : super(key: key);

  @override
  State<Goallumpsum> createState() => _LumpsumscreenState();
}

class _LumpsumscreenState extends State<Goallumpsum> {
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _inflationController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _annualInterestController =
      TextEditingController();

  double _maturityValue = 0.0;
  double _amountInvested = 0.0;
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

  double inflationAdjustedTargetedWealth(
      double targetedWealth, int years, double inflation) {
    return targetedWealth * pow((1 + inflation / 100), years);
  }

  double investedAmount(double targetedWealth, double annualInterestRate,
      int years, double inflation) {
    double amountInvested =
        inflationAdjustedTargetedWealth(targetedWealth, years, inflation) /
            pow((1 + annualInterestRate / 100), years);
    return amountInvested;
  }

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double inflation = double.parse(_inflationController.text);
    int years = int.parse(_yearsController.text);
    double annualInterestRate = double.parse(_annualInterestController.text);
    setState(() {
      _maturityValue =
          inflationAdjustedTargetedWealth(targetedWealth, years, inflation);
      _amountInvested =
          investedAmount(targetedWealth, annualInterestRate, years, inflation);
    });
    saveCalculation(type: 'Goal planning - lumpsum', inputs: {
      'targetedwealth': targetedWealth,
      'assumedinflation': inflation,
      'time period': years,
      'return(%)': annualInterestRate,
    }, outputs: {
      'lumpsuminvestmentamount': _maturityValue,
    });
  }

  void reset() {
    (_inflationController.clear());
    (_targetedWealthController.clear());
    (_yearsController.clear());
    (_annualInterestController.clear());
    setState(() {
      _maturityValue = 0.0;
      _amountInvested = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(title: const Text("Goal Planning - Lumpsum ")),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Inputfield(
                    controller: _targetedWealthController,
                    hintText: "Targeted Wealth (in Rs.)",
                  ),
                  const SizedBox(height: 30),
                  Inputfield(
                    controller: _inflationController,
                    hintText: "Expected Inflation (in % p.a.)",
                  ),
                  const SizedBox(height: 30),
                  Inputfield(
                    controller: _yearsController,
                    hintText: "Time period (upto 50 years)",
                  ),
                  const SizedBox(height: 30),
                  Inputfield(
                    controller: _annualInterestController,
                    hintText: "Expected return (in % p.a)",
                  ),
                  const SizedBox(height: 30),
                  Custombutton(
                      action: "Plan my goal",
                      onTap: _calculate,
                      buttonWidth: buttonWidth),
                  const SizedBox(height: 30),
                  Custombutton(
                      action: "Reset", onTap: reset, buttonWidth: buttonWidth),
                  const SizedBox(height: 30),
                  Text(
                      'Inflation adjusted targeted wealth: Rs. ${_maturityValue.toStringAsFixed(2)}'),
                  const SizedBox(height: 30),
                  Text(
                      'Investment amount needed: Rs. ${_amountInvested.toStringAsFixed(2)}'),
                ],
              ),
            ),
          )),
    );
  }
}
