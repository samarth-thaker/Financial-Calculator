import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class SIPGoal extends StatefulWidget {
  const SIPGoal({Key? key}) : super(key: key);

  @override
  State<SIPGoal> createState() => _SIPGoalScreen();
}

class _SIPGoalScreen extends State<SIPGoal> {
  final TextEditingController _monthlyInvestmentController =
      TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _inflationController = TextEditingController();

  // double _maturityValue = 0.0;
  //double _amountInvested = 0.0;
  //double _earnings = 0.0;
  double _investmentPerMonth = 0.0;
  double inflationAdjustedTargetedWealth(
      double targetedWealth, int years, double inflation) {
    return targetedWealth * pow((1 + inflation / 100), years);
  }

  double monthlyInvestment(double targetedWealth, double annualInterestRate,
      int years, double inflation) {
    double futureValue =
        inflationAdjustedTargetedWealth(targetedWealth, years, inflation);
    double monthlyRate = (annualInterestRate / 100) / 12;
    int months = years * 12; // Total number of months

    double denominator =
        pow(1 + monthlyRate, months - 1) / monthlyRate * (1 + monthlyRate);
    double sipAmount = futureValue / denominator;
    return sipAmount;
  }

  /* double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  } */

/*   double amountEarned(
      double monthlyInvestment, double annualInterestRate, int years) {
    return calculateSIPMaturity(monthlyInvestment, annualInterestRate, years) -
        investedAmount(monthlyInvestment, annualInterestRate, years);
  } */

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);
    double inflation = double.parse(_inflationController.text);

    setState(() {
      _investmentPerMonth = monthlyInvestment(
          targetedWealth, annualInterestRate, years, inflation);
      //_amountInvested = investedAmount(monthlyInvestment, annualInterestRate, years);
      //_earnings = amountEarned(monthlyInvestment, annualInterestRate, years);
    });
  }

  void reset() {
    (_annualInterestRateController.clear());
    (_targetedWealthController.clear());
    (_yearsController.clear());
    (_inflationController.clear());
    setState(() {
      _investmentPerMonth = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("Goal Planning - SIP")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Inputfield(
              controller: _monthlyInvestmentController,
              hintText: "Targeted Wealth (in Rs.)",
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
            Inputfield(
              controller: _inflationController,
              hintText: "Adjust for inflation",
            ),
            const SizedBox(height: 30),
           
            Custombutton(
                action: "Plan SIP Goal",
                onTap: _calculate,
                buttonWidth: buttonWidth),
            const SizedBox(height: 30),
            Custombutton(
                action: "Reset", onTap: reset, buttonWidth: buttonWidth),
            const SizedBox(height: 30),
            Text(
                'Monthly Investment Required: Rs. ${_investmentPerMonth.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            
          ],
        ))),
      ),
    );
  }
}
