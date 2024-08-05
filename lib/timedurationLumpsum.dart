import 'package:flutter/material.dart';
import 'dart:math';

class TimeDurationLumpsum extends StatefulWidget {
  const TimeDurationLumpsum({Key? key}) : super(key: key);

  @override
  State<TimeDurationLumpsum> createState() => _TimeDurationOneTimeScreen();
}

class _TimeDurationOneTimeScreen extends State<TimeDurationLumpsum> {
  final TextEditingController _annualInterestRateController = TextEditingController();
  final TextEditingController _targetedWealthController = TextEditingController();
  final TextEditingController _initialInvestmentController = TextEditingController();
  double timeYears = 0.0;

  double calculateYears(double targetedWealth, double initialInvestment, double annualInterestRate) {
    double years = log(targetedWealth / initialInvestment) / log(1 + annualInterestRate / 100);
    return years;
  }

  void _calculate() {
    double targetedWealth = double.parse(_targetedWealthController.text);
    double annualInterestRate = double.parse(_annualInterestRateController.text);
    double initialInvestment = double.parse(_initialInvestmentController.text);

    setState(() {
      timeYears = calculateYears(targetedWealth, initialInvestment, annualInterestRate);
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

  Widget customTextButton(String action, VoidCallback onTap,double buttonWidth, {double width = 150.0}) {
    return Container(
      width: buttonWidth,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color.fromARGB(249, 0, 114, 188)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          action,
          style: const TextStyle(color: Color.fromARGB(249, 250, 200, 20), fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; 
    return Scaffold(
      appBar: AppBar(title: const Text("Time Duration - One Time")),
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
                    controller: _initialInvestmentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(249, 0, 114, 188),
                        ),
                      ),
                      hintText: "Initial Investment",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 30),
                customTextButton('Calculate Time Duration', _calculate, buttonWidth),
                const SizedBox(height: 30),
                customTextButton('Reset', reset, buttonWidth),
                const SizedBox(height: 30),
                Text(
                    'Total Investment Period: ${timeYears.toStringAsFixed(2)} Years'),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),    );
  }
}
