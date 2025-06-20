import 'package:financial_calculator/auth/login.dart';
import 'package:financial_calculator/auth/signup.dart';
import 'package:financial_calculator/calculators/cagrCalc.dart';
import 'package:financial_calculator/calculators/emicalc.dart';
import 'package:financial_calculator/calculators/fdCalculator.dart';
import 'package:financial_calculator/calculators/fireCalculator.dart';
import 'package:financial_calculator/calculators/goalLumpsum.dart';
import 'package:financial_calculator/calculators/goalSip.dart';
import 'package:financial_calculator/calculators/rdCalculator.dart';
import 'package:financial_calculator/calculators/sip.dart';
import 'package:financial_calculator/calculators/siplumpsum.dart';
import 'package:financial_calculator/calculators/stepupsip.dart';
import 'package:financial_calculator/calculators/timelumpsum.dart';
import 'package:financial_calculator/calculators/timesip.dart';
import 'package:financial_calculator/dashboard.dart';
import 'package:financial_calculator/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Loginscreen(),
      routes: {
        '/dashboard':(context)=>const DashboardScreen(),
        '/sipcalculator': (context) => const SIPscreen(),
        "/siplumpsum": (context) => const Lumpsumscreen(),
        '/cagrCalc': (context) => const Cagrscreen(),
        '/fixedDepositCalculator': (context) => const FDscreen(),
        '/recDeposit': (context) => const RDscreen(),
        '/stepupSIP': (context) => const UPscreen(),
        '/fireCalculator': (context) => const FireScreen(),
        '/goalLumpsum': (context) => const Goallumpsum(),
        '/goalSip': (context) => const SIPGoal(),
        '/timedurationLumpsum': (context) => const TimeDurationLumpsum(),
        '/timedurationRegular': (context) => const TimeDurationRegularScreen(),
        '/emiCalc': (context) => const EmiScreen(),
        '/loginScreen':(context)=> const Loginscreen(),
        '/signupScreen':(context)=>const SignupScreen(),
      },
    );
  }
}

