import 'package:flutter/material.dart';
import 'dart:math';

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
  Widget customTextButton(String action, VoidCallback onTap,double buttonWidth, {double width = 150.0}) {
    return Container(
      width: buttonWidth,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color.fromARGB(249, 0, 114, 188)),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          action,
          style: TextStyle(color: Color.fromARGB(249, 250, 200, 20), fontSize: 20),
        ),
      ),
    );
  }

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
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Independence Retire Early Calculator"),
      ),
      body:Center(
        child: SingleChildScrollView(
          child:Padding(
        padding: const EdgeInsets.all(20.0),
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
            SizedBox(
              width: 300,
              child: TextField(
                controller: _currentAgeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Current Age ",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _retirementAgeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Retirement Age",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _inflationRateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Assumed inflation (in %)",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 30),
            customTextButton("Calculate my fire", calculate, buttonWidth),
            const SizedBox(height: 30),
            customTextButton("Reset", reset, buttonWidth),
            const SizedBox(height: 30),
            Text('Expense today: Rs. ${expenseToday.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('FIRE: Rs. ${fire.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('FAT FIRE: Rs. ${fatFire.toStringAsFixed(2)}'),
          ],
        ),
      ),

        ),
      ) 
          );
  }
}
