import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({Key? key}) : super(key: key);

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
/*   final TextEditingController _emiController = TextEditingController();
 */
  final TextEditingController _annualInterestRateController =
      TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _principalController = TextEditingController();

  double _emi = 0.0;
  /* double _amountInvested = 0.0;
  double _earnings = 0.0; */

  /* double amountPaid(
      double principalAmount, double annualInterestRate, int years) {
    double emi = monthlyInstallment(principalAmount, annualInterestRate, years);
    int months = years * 12; // Total number of months

    double maturityValue = monthlyInvestment *
        (pow(1 + monthlyRate, months) - 1) /
        monthlyRate *
        (1 + monthlyRate);
    return maturityValue;
  } */

  double monthlyInstallment(
      double principalAmount, double annualInterestRate, int years) {
    double r = annualInterestRate / 1200;
    int n = years * 12;
    return (principalAmount * r * pow((1 + r), years * 12)) /
        (pow((1 + r), n) - 1);
  }

  /* double amountEarned(
      double monthlyInvestment, double annualInterestRate, int years) {
    return calculateSIPMaturity(monthlyInvestment, annualInterestRate, years) -
        investedAmount(monthlyInvestment, annualInterestRate, years);
  } */

  void _calculate() {
    double principal = double.parse(_principalController.text);
    double annualInterestRate =
        double.parse(_annualInterestRateController.text);
    int years = int.parse(_yearsController.text);

    setState(() {
      _emi = monthlyInstallment(principal, annualInterestRate, years);
      /*  _amountInvested =
          investedAmount(monthlyInvestment, annualInterestRate, years); */
      /* _earnings = amountEarned(monthlyInvestment, annualInterestRate, years); */
    });
  }

  Widget customTextButton(String action, VoidCallback onTap, double buttonWidth, {double width = 150.0}) {
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

  void reset() {
    _principalController.clear();
    _annualInterestRateController.clear();
    _yearsController.clear();
    setState(() {
      _emi = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.8; //
    return Scaffold(
      appBar: AppBar(title: const Text("EMI Calculator")),
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
                    controller: _principalController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(249, 0, 114, 188),
                        ),
                      ),
                      hintText: "Loan amount (in Rs.)",
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
                      hintText: "Rate of interest (in % p.a)",
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
                customTextButton('Calculate EMI', _calculate, buttonWidth),
                const SizedBox(height: 30),
                customTextButton('Reset', reset, buttonWidth),
                const SizedBox(height: 30),
                Text(
                    'EMI: Rs.${_emi.toStringAsFixed(2)}'),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
