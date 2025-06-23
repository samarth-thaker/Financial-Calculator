import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class UPscreen extends StatefulWidget {
  const UPscreen({Key? key}) : super(key: key);

  @override
  State<UPscreen> createState() => _UPscreenState();
}

class _UPscreenState extends State<UPscreen> {
  final TextEditingController _monthlyInvestmentController =
      TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _stepUpController = TextEditingController();

  double _maturityValue = 0.0;
  double _amountInvested = 0.0;
  double _earnings = 0.0;
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

  double calculateSIPMaturity(double monthlyInvestment,
      double annualInterestRate, int years, double stepUpPercentage) {
    double monthlyRate = (annualInterestRate / 100) / 12;
    double maturityValue = 0;

    for (int year = 0; year < years; year++) {
      for (int month = 0; month < 12; month++) {
        int monthsRemaining = (years * 12) - (year * 12 + month);
        maturityValue +=
            monthlyInvestment * pow(1 + monthlyRate, monthsRemaining);
      }

      monthlyInvestment += monthlyInvestment * (stepUpPercentage / 100);
    }

    return maturityValue;
  }

  double investedAmount(double monthlyInvestment, double annualInterestRate,
      int years, double s) {
    double amountInvested = 0;
    for (int year = 0; year < years; year++) {
      for (int month = 0; month < 12; month++) {
        amountInvested += monthlyInvestment;
      }
      monthlyInvestment += monthlyInvestment * (s / 100);
    }
    return amountInvested;
  }

  double amountEarned(double monthlyInvestment, double annualInterestRate,
      int years, double s) {
    return calculateSIPMaturity(
            monthlyInvestment, annualInterestRate, years, s) -
        investedAmount(monthlyInvestment, annualInterestRate, years, s);
  }

  void _calculate() {
    double monthlyInvestment = double.parse(_monthlyInvestmentController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);
    double s = double.parse(_stepUpController.text);
    setState(() {
      _maturityValue =
          calculateSIPMaturity(monthlyInvestment, annualInterestRate, years, s);
      _amountInvested =
          investedAmount(monthlyInvestment, annualInterestRate, years, s);
      _earnings = amountEarned(monthlyInvestment, annualInterestRate, years, s);
    });
    saveCalculation(type: 'Step up sip', inputs: {
      'monthlyinvestment': monthlyInvestment,
      'return(%)': annualInterestRate,
      'stepup(%)': s,
      'time period': years,
    }, outputs: {
      'stepupmaturity':_maturityValue,
      'amountinvested':_amountInvested,
    });
  }

  void reset() {
    _monthlyInvestmentController.clear();
    _stepUpController.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _maturityValue = 0.0;
      _earnings = 0.0;
      _amountInvested = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("Step Up SIP Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Inputfield(
                  controller: _monthlyInvestmentController,
                  hintText: "Investment per month (in Rs.)",
                ),
                const SizedBox(height: 30),
                Inputfield(
                  controller: _stepUpController,
                  hintText: "Annual Step up (in %)",
                ),
                const SizedBox(height: 30),
                Inputfield(
                  controller: _annualInterestRateController,
                  hintText: "Expected return (in % p.a)",
                ),
                const SizedBox(height: 30),
                Inputfield(
                  controller: _yearsController,
                  hintText: "Time period (upto 50 years)",
                ),
                const SizedBox(height: 30),
                Custombutton(
                    action: 'Calculate my wealth',
                    onTap: _calculate,
                    buttonWidth: buttonWidth),
                const SizedBox(height: 30),
                Custombutton(
                    action: "Reset", onTap: reset, buttonWidth: buttonWidth),
                const SizedBox(height: 30),
                Text(
                    'Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
                const SizedBox(height: 30),
                Text(
                    'Amount invested: Rs. ${_amountInvested.toStringAsFixed(2)}'),
                const SizedBox(height: 30),
                Text('Earnings: Rs. ${_earnings.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
