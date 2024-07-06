import 'package:flutter/material.dart';
import 'dart:math';

class EmiScreen extends StatefulWidget {
  const EmiScreen({Key? key}) : super(key: key);

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
/*   final TextEditingController _emiController = TextEditingController();
 */  final TextEditingController _annualInterestRateController =
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
  Widget customTextButton(String action, VoidCallback onTap, {double width = 150.0}) {
  return Container(
    width: 175,
    
    child: TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Color.fromARGB(249, 0, 114, 188)), 
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 12)), 
      ),
      child: Text(
        action,
        style: TextStyle(color: Color.fromARGB(249, 250, 200, 20), fontSize: 24),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EMI Calculator")),
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
                  hintText: "Loan amount (in Rs.)",
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
                  hintText: "Rate of interest (in % p.a)",
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
           customTextButton('Calculate EMI', _calculate),
            const SizedBox(height: 30),
            Text('EMI: Rs. ${_emi.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            /* Text('Amount invested: Rs. ${_amountInvested.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('Earnings: Rs. ${_earnings.toStringAsFixed(2)}'), */
          ],
        ),
      ),
    );
  }
}
