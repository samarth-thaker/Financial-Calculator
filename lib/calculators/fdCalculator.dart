import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FDscreen extends StatefulWidget {
  const FDscreen({Key? key}) : super(key: key);

  @override
  State<FDscreen> createState() => _FDscreenState();
}

class _FDscreenState extends State<FDscreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _maturityValue = 0.0;

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

  double fdMaturity(double p, double annualInterestRate, int years) {
    double maturityValue = p + ((p * annualInterestRate * years) / 100);
    return maturityValue;
  }

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  double amountEarned(double p, double annualInterestRate, int years) {
    return fdMaturity(p, annualInterestRate, years) - p;
  }

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _maturityValue = fdMaturity(principal, annualInterestRate, years);
    });
    saveCalculation(type: 'Fixed deposit', inputs: {
      'principal': principal,
      'return(%)': annualInterestRate,
      'time period': years,
    }, outputs: {
      'fdAmount': _maturityValue,
    });
  }

  void reset() {
    _principalController.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _maturityValue = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("Fixed Deposit Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Inputfield(
                controller: _principalController,
                hintText: "Total Investment (in Rs.)",
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
                  action: "Calculate my Wealth",
                  onTap: _calculate,
                  buttonWidth: buttonWidth),
              const SizedBox(height: 30),
              Custombutton(
                  action: "Reset", onTap: reset, buttonWidth: buttonWidth),
              const SizedBox(height: 30),
              Text('Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
              const SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }
}
