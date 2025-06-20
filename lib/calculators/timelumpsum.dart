import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
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
