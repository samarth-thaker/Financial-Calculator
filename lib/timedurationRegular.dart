//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

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
  //final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _targetedWealthController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _inflationController = TextEditingController();
  final TextEditingController _initialInvestmentController =
      TextEditingController();
  final TextEditingController _expectedReturnController =
      TextEditingController();
  double timeYears = 0.0;
  double calculateYears(double targetedWealth, double monthlyInvestment,
      double annualInterestRate) {
    double years = 0.0;
    double num =
        (targetedWealth * annualInterestRate / 1200 + monthlyInvestment) /
            monthlyInvestment;
    years = log(num) / (12 * log(1 + annualInterestRate / 1200));
    return years;
  }

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    //int years = int.parse(_yearsController.text);
    double initialInvestment = double.parse(_initialInvestmentController.text);
    setState(() {
      timeYears =
          calculateYears(targetedWealth, initialInvestment, annualInterestRate);
    });
  }

  void reset() {
    (_targetedWealthController.clear());
    (_expectedReturnController.clear());
    (_monthlyInvestmentController.clear());
    (_inflationController.clear());
    setState(() {
      timeYears = 0.0;
    });
  }

  Widget customTextButton(String action, VoidCallback onTap,
      {double width = 150.0}) {
    return Container(
      width: 230,
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
    return Scaffold(
      appBar: AppBar(title: const Text("Time Duration - Regular")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              width: 300,
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
              width: 300,
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
              width: 300,
              child: TextField(
                controller: _monthlyInvestmentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Mothly Investment",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _yearsController,
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
            customTextButton('Calculate Time Duration', _calculate),
            const SizedBox(height: 30),
            customTextButton('Reset', reset),
            const SizedBox(height: 30),
            Text(
                'Total Investment Period: ${timeYears.toStringAsFixed(2)} Years'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
