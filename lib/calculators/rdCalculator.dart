import 'package:financial_calculator/widgets/customTextButton.dart';
import 'package:financial_calculator/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class RDscreen extends StatefulWidget {
  const RDscreen({Key? key}) : super(key: key);

  @override
  State<RDscreen> createState() => _RDscreenState();
}

class _RDscreenState extends State<RDscreen> {
  final TextEditingController _monthlyInvestment = TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _maturityValue = 0.0;
  double _amountInvested = 0.0;
  double _earnings = 0.0;

  double rdMaturity(
      double monthlyDeposit, double annualInterestRate, int years) {
    double monthlyRate =
        (annualInterestRate / 100) / 12; // Monthly interest rate
    int months = years * 12; // Total number of months

    double maturityValue = 0;

    for (int i = 0; i < months; i++) {
      maturityValue += monthlyDeposit * pow(1 + monthlyRate, months - i);
    }

    return maturityValue;
  }

  void reset() {
    _monthlyInvestment.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _amountInvested = 0.0;
      _maturityValue = 0.0;
      _earnings = 0.0;
    });
  }

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  double amountEarned(double p, double annualInterestRate, int years) {
    return rdMaturity(p, annualInterestRate, years) -
        investedAmount(p, annualInterestRate, years);
  }

  void _calculate() {
    double principal = double.parse(_monthlyInvestment.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _maturityValue = rdMaturity(principal, annualInterestRate, years);
      _amountInvested = investedAmount(principal, annualInterestRate, years);
      _earnings = amountEarned(principal, annualInterestRate, years);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("Recurring Deposit Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child:SingleChildScrollView(
            child: Column(
              children: [
            Inputfield(
              
                controller: _monthlyInvestment,
               
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
            /* TextButton(
              onPressed: _calculate,
              child: const Text("Calculate my wealth"),
            ) */
            customTextButton("Calculate my wealth", _calculate, buttonWidth),
            const SizedBox(height: 30),
           Custombutton(action: "Reset",onTap: reset, buttonWidth:buttonWidth),
            const SizedBox(height: 30),
            Text('Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Amount invested: Rs. ${_amountInvested.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Earnings: Rs. ${_earnings.toStringAsFixed(2)}'),
          ],

            ),
          )
                  ),
      ),
    );
  }
}