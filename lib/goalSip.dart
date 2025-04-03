import 'package:flutter/material.dart';
import 'dart:math';

class SIPGoal extends StatefulWidget {
  const SIPGoal({super.key});

  @override
  State<SIPGoal> createState() => _SIPGoalScreen();
}

class _SIPGoalScreen extends State<SIPGoal> {
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _inflationController = TextEditingController()  ;

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

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);
    double inflation = double.parse(_inflationController.text);

    setState(() {
      _investmentPerMonth = monthlyInvestment(
          targetedWealth, annualInterestRate, years, inflation);
    });
  }

  Widget customTextButton(
      String action, VoidCallback onTap, double buttonWidth) {
    return SizedBox(
      width: buttonWidth,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(const Color.fromARGB(249, 0, 114, 188)),
          padding:
              WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          action,
          style: const TextStyle(
              color: Color.fromARGB(249, 250, 200, 20), fontSize: 20),
        ),
      ),
    );
  }

  void reset() {
    _annualInterestRateController.clear();
    _targetedWealthController.clear();
    _yearsController.clear();
    _inflationController.clear();
    setState(() {
      _investmentPerMonth = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(title: const Text("Goal Planning - SIP")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  child: TextField(
                    controller: _targetedWealthController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(249, 0, 114, 188),
                        ),
                      ),
                      hintText: "Targeted Wealth (in Rs.)",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: screenWidth * 0.8,
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
                  width: screenWidth * 0.8,
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
                SizedBox(
                  width: screenWidth * 0.8,
                  child: TextField(
                    controller: _inflationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(249, 0, 114, 188),
                        ),
                      ),
                      hintText: "Adjust for inflation",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 30),
                customTextButton("Plan SIP Goal", _calculate, buttonWidth),
                const SizedBox(height: 30),
                customTextButton("Reset", reset, buttonWidth),
                const SizedBox(height: 30),
                Text(
                    'Monthly Investment Required: Rs. ${_investmentPerMonth.toStringAsFixed(2)}'),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
