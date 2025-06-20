import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class FireScreen extends StatefulWidget {
  const FireScreen({super.key});

  @override
  State<FireScreen> createState() => _FIREState();
}

class _FIREState extends State<FireScreen> {
  final TextEditingController _monthlyExpenseController =
      TextEditingController();
  final TextEditingController _currentAgeController = TextEditingController();
  final TextEditingController _retirementAgeController =
      TextEditingController();
  final TextEditingController _inflationRateController =
      TextEditingController();
  double leanFire = 0.0;
  double fatFire = 0.0;
  double fire = 0.0;
  double expenseToday = 0.0;
  double expenseInFuture = 0.0;

  double fireNumber(double monthlyExpense, int currentAge, int retirementAge,
      double inflation) {
    double annualExpense =
        future(monthlyExpense, currentAge, retirementAge, inflation);
    return annualExpense /
        0.04; // Adjust this if needed based on your withdrawal rate assumption
  }

  double fat(double monthlyExpense, int currentAge, int retirementAge,
      double inflation) {
    double fatMonthlyExpense = monthlyExpense * 1.5;
    return fireNumber(fatMonthlyExpense, currentAge, retirementAge, inflation);
  }

  double today(double monthlyExpense) {
    return monthlyExpense * 12;
  }

  double future(double monthlyExpense, int currentAge, int retirementAge,
      double inflation) {
    double rate = inflation / 100;
    double sum = 1 + rate;
    int diff = retirementAge - currentAge;
    return monthlyExpense * pow(sum, diff) * 12;
  }

  /* double lean(double monthlyExpense) {
    return monthlyExpense * 12 * 20;
  } */

  void calculate() {
    double monthlyExpense =
        double.tryParse(_monthlyExpenseController.text) ?? 0.0;
    int currentAge = int.tryParse(_currentAgeController.text) ?? 0;
    int retirementAge = int.tryParse(_retirementAgeController.text) ?? 0;
    double inflation = double.tryParse(_inflationRateController.text) ?? 0.0;

    setState(() {
      expenseToday = today(monthlyExpense) * 12;
      expenseInFuture =
          future(monthlyExpense, currentAge, retirementAge, inflation);
      fatFire = fat(monthlyExpense, currentAge, retirementAge, inflation);
      fire = fireNumber(monthlyExpense, currentAge, retirementAge, inflation);
    });
  }

  void reset() {
    _monthlyExpenseController.clear();
    _currentAgeController.clear();
    _retirementAgeController.clear();
    _inflationRateController.clear();
    setState(() {
      expenseToday = 0.0;
      expenseInFuture = 0.0;
      fatFire = 0.0;
      fire = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Independence Retire Early Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _monthlyExpenseController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(249, 0, 114, 188),
                      ),
                    ),
                    hintText: "Monthly Expense (in Rs.)",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 30),
              Inputfield(
                controller: _currentAgeController,
                hintText: "Current Age ",
              ),
              const SizedBox(height: 30),
              Inputfield(
                controller: _retirementAgeController,
                hintText: "Retirement Age",
              ),
              const SizedBox(height: 30),
              Inputfield(
                controller: _inflationRateController,
                hintText: "Assumed inflation (in %)",
              ),
              const SizedBox(height: 30),
              Custombutton(
                  action: "Calculate my fire",
                  onTap: calculate,
                  buttonWidth: buttonWidth),
              const SizedBox(height: 30),
              Custombutton(
                  action: "Reset", onTap: reset, buttonWidth: buttonWidth),
              const SizedBox(height: 30),
              Text('Expense today: Rs. ${expenseToday.toStringAsFixed(2)}'),
              const SizedBox(height: 30),
              Text('FIRE: Rs. ${fire.toStringAsFixed(2)}'),
              const SizedBox(height: 30),
              Text('FAT FIRE: Rs. ${fatFire.toStringAsFixed(2)}'),
            ],
          ),
        )),
      ),
    );
  }
}
