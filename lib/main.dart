

import 'package:flutter/material.dart';
import 'package:financialcalculator/cagrCalc.dart';
import 'package:financialcalculator/dashboard.dart';
import 'package:financialcalculator/emiCalc.dart';
import 'package:financialcalculator/fireCalculator.dart';
import 'package:financialcalculator/fixedDepositCalculator.dart';
import 'package:financialcalculator/recDeposit.dart';
import 'package:financialcalculator/sipcalculator.dart';
import 'package:financialcalculator/siplumpsum.dart';
import 'package:financialcalculator/stepupSIP.dart';
import 'package:financialcalculator/goalLumpsum.dart';
import 'package:financialcalculator/goalSip.dart';
import 'package:financialcalculator/timedurationLumpsum.dart';
import 'package:financialcalculator/timedurationRegular.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
      routes: {
        '/sipcalculator': (context) => const SIPscreen(),
        "/siplumpsum": (context) => const Lumpsumscreen(),
        '/cagrCalc': (context) => const Cagrscreen(),
        '/fixedDepositCalculator': (context) => const FDscreen(),
        '/recDeposit': (context) => const RDscreen(),
        '/stepupSIP': (context) => const UPscreen(),
        '/cagrCalc': (context) => const Cagrscreen(),
        '/fireCalculator': (context) => const FireScreen(),
        '/goalLumpsum': (context) => const Goallumpsum(),
        '/goalSip': (context) => const SIPGoal(),
        '/timedurationLumpsum': (context) => const TimeDurationLumpsum(),
        '/timedurationRegular': (context) => const TimeDurationRegularScreen(),
        '/emiCalc': (context) => const EmiScreen(),
      },
    );
  }
}
