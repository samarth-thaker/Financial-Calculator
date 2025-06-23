import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TimeDurationLumpsum extends StatefulWidget {
  const TimeDurationLumpsum({Key? key}) : super(key: key);

  @override
  State<TimeDurationLumpsum> createState() => _TimeDurationOneTimeScreen();
}

class _TimeDurationOneTimeScreen extends State<TimeDurationLumpsum> {
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _initialInvestmentController =
      TextEditingController();
  double timeYears = 0.0;
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

  double calculateYears(double targetedWealth, double initialInvestment,
      double annualInterestRate) {
    double years = log(targetedWealth / initialInvestment) /
        log(1 + annualInterestRate / 100);
    return years;
  }

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    double initialInvestment = double.parse(_initialInvestmentController.text);

    setState(() {
      timeYears =
          calculateYears(targetedWealth, initialInvestment, annualInterestRate);
    });
    saveCalculation(type: 'Time duration lumpsum', inputs: {
      'targetedwealth': targetedWealth,
      'initialinvestment': initialInvestment,
      'return(%)': annualInterestRate,
    }, outputs: {
      'timedurationOnetime':timeYears,
    });
  }

  void reset() {
    _targetedWealthController.clear();
    _annualInterestRateController.clear();
    _initialInvestmentController.clear();
    setState(() {
      timeYears = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("Time Duration - One Time")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
                  controller: _annualInterestRateController,
                  hintText: "Expected return (in % p.a)",
                ),
                const SizedBox(height: 30),
                Inputfield(
                  controller: _initialInvestmentController,
                  hintText: "Initial Investment",
                ),
                const SizedBox(height: 30),
                Custombutton(
                    action: "Calculate Time Duration",
                    onTap: _calculate,
                    buttonWidth: buttonWidth),
                const SizedBox(height: 30),
                Custombutton(
                    action: "Reset", onTap: reset, buttonWidth: buttonWidth),
                const SizedBox(height: 30),
                Text(
                    'Total Investment Period: ${timeYears.toStringAsFixed(2)} Years'),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
