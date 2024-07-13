import 'package:flutter/material.dart';
import 'dart:math';

class Lumpsumscreen extends StatefulWidget {
  const Lumpsumscreen({Key? key}) : super(key: key);

  @override
  State<Lumpsumscreen> createState() => _LumpsumscreenState();
}

class _LumpsumscreenState extends State<Lumpsumscreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  //final TextEditingController _amountInvestedController = TextEditingController();

  double _maturityValue = 0.0;
  /* double _amountInvested = 0.0;
  double _earnings = 0.0; */

  double calculateLumpsumMaturity(
      double p, double annualInterestRate, int years) {
    /*  double monthlyRate =
        (annualInterestRate / 100) / 12; */ // Monthly interest rate
    /* int months = years * 12;  */ // Total number of months

    double maturityValue = p * pow((1 + annualInterestRate / 100), years);
    return maturityValue;
  }

  double investedAmount(
      double monthlyInvestment, double annualInterestRate, int years) {
    double amountInvested = monthlyInvestment * years * 12;
    return amountInvested;
  }

  double amountEarned(double p, double annualInterestRate, int years) {
    return calculateLumpsumMaturity(p, annualInterestRate, years) - p;
  }

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _maturityValue =
          calculateLumpsumMaturity(principal, annualInterestRate, years);
    });
  }

  void reset() {
    (_principalController.clear());
    (_annualInterestRateController.clear());
    (_yearsController.clear());
    setState(() {
      _maturityValue = 0.0;
    });
  }

  Widget customTextButton(String action, VoidCallback onTap,
      {double width = 150.0}) {
    return Container(
      width: 200,
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
      appBar: AppBar(title: const Text("Lumpsum SIP Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _principalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(249, 0, 114, 188),
                    ),
                  ),
                  hintText: "Lumpsum deposit amount (in Rs.)",
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
            customTextButton("Calcualte my wealth", _calculate),
            const SizedBox(height: 30),
            customTextButton('Reset', reset),
            const SizedBox(height: 30),
            Text('Maturity value: Rs. ${_maturityValue.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            /* Text('Amount invested: Rs. ${_amountInvested.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Earnings: Rs. ${_earnings.toStringAsFixed(2)}'),
 */
          ],
        ),
      ),
    );
  }
}
