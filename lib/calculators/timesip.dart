import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TimeDurationRegularScreen extends StatefulWidget {
  const TimeDurationRegularScreen({Key? key}) : super(key: key);

  @override
  State<TimeDurationRegularScreen> createState() =>
      _TimeDurationRegularScreen();
}

class _TimeDurationRegularScreen extends State<TimeDurationRegularScreen> {
  final TextEditingController _monthlyInvestmentController =
      TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _initialInvestmentController =
      TextEditingController();
  double timeYears = 0.0;

  double calculateYears(double targetedWealth, double monthlyInvestment,
      double annualInterestRate) {
    double num =
        (targetedWealth * annualInterestRate / 1200 + monthlyInvestment) /
            monthlyInvestment;
    double years = log(num) / (12 * log(1 + annualInterestRate / 1200));
    return years;
  }

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    double monthlyInvestment = double.parse(_monthlyInvestmentController.text);

    setState(() {
      timeYears =
          calculateYears(targetedWealth, monthlyInvestment, annualInterestRate);
    });
  }

  void reset() {
    _targetedWealthController.clear();
    _annualInterestRateController.clear();
    _monthlyInvestmentController.clear();
    _initialInvestmentController.clear();
    setState(() {
      timeYears = 0.0;
    });
  }

  Widget customTextButton(String action, VoidCallback onTap, double buttonWidth,
      {double width = 150.0}) {
    return Container(
      width: buttonWidth,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(Color.fromARGB(249, 0, 114, 188)),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          action,
          style:
              TextStyle(color: Color.fromARGB(249, 250, 200, 20), fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(title: const Text("Time Duration - Regular")),
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
                  controller: _annualInterestRateController,
                  hintText: "Expected return (in % p.a)",
                ),
                const SizedBox(height: 30),
                Inputfield(
                  controller: _monthlyInvestmentController,
                  hintText: "Monthly Investment",
                ),
                const SizedBox(height: 30),
                customTextButton(
                    'Calculate Time Duration', _calculate, buttonWidth),
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
