import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class SIPscreen extends StatefulWidget {
  const SIPscreen({Key? key}) : super(key: key);

  @override
  State<SIPscreen> createState() => _SIPscreenState();
}

class _SIPscreenState extends State<SIPscreen> {
  final TextEditingController _monthlyInvestmentController =
      TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  //final TextEditingController _amountInvestedController = TextEditingController();

  double _maturityValue = 0.0;
  double _amountInvested = 0.0;
  double _earnings = 0.0;

  double calculateSIPMaturity(
      double monthlyInvestment, double annualInterestRate, int years) {
    double monthlyRate =
        (annualInterestRate / 100) / 12; // Monthly interest rate
    int months = years * 12; // Total number of months

    double maturityValue = monthlyInvestment *
        (pow(1 + monthlyRate, months) - 1) /
        monthlyRate *
        (1 + monthlyRate);
    return maturityValue;
  }

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  double amountEarned(
      double monthlyInvestment, double annualInterestRate, int years) {
    return calculateSIPMaturity(monthlyInvestment, annualInterestRate, years) -
        investedAmount(monthlyInvestment, annualInterestRate, years);
  }


  void reset() {
    (_monthlyInvestmentController.clear());
    (_annualInterestRateController.clear());
    (_yearsController.clear());
    setState(() {
      _maturityValue = 0.0;
      _amountInvested = 0.0;
      _earnings = 0.0;
    });
  }

  void _calculate() {
    double monthlyInvestment = double.parse(_monthlyInvestmentController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _maturityValue =
          calculateSIPMaturity(monthlyInvestment, annualInterestRate, years);
      _amountInvested =
          investedAmount(monthlyInvestment, annualInterestRate, years);
      _earnings = amountEarned(monthlyInvestment, annualInterestRate, years);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("SIP Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child:SingleChildScrollView(
            child:Column(
              children: [
           Inputfield(
              
                controller: _monthlyInvestmentController,
               
                  hintText: "Monthly investment (in Rs.)",
                 
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
            Custombutton( action: 'Calculate',onTap:  _calculate,buttonWidth:  buttonWidth),
            const SizedBox(height: 30),
           Custombutton(action: "Reset",onTap: reset, buttonWidth:buttonWidth),
            const SizedBox(height: 30),
            Text('Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Amount invested: Rs. ${_amountInvested.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Earnings: Rs. ${_earnings.toStringAsFixed(2)}'),
          ],

            )
          )
                  ),
      ),
    );
  }
}