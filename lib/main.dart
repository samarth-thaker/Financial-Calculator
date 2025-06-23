import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:financial_calculator/firebase_options.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    
    await dotenv.load(fileName: "assets/.env");
    print("✅ Environment variables loaded successfully");
    
    
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully");
    
    runApp(const MyApp());
    
  } catch (e) {
    print("❌ Error during initialization: $e");
    
    runApp(ErrorApp(error: e.toString()));
  }
}


class ErrorApp extends StatelessWidget {
  final String error;
  
  const ErrorApp({super.key, required this.error});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Initialization Error',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkFirebaseInitialization(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Initializing app...'),
                  ],
                ),
              ),
            );
          }
          
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 20),
                    const Text('Firebase Error'),
                    Text(snapshot.error.toString()),
                  ],
                ),
              ),
            );
          }
          
          return const Loginscreen();
        },
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/sipcalculator': (context) => const SIPscreen(),
        '/siplumpsum': (context) => const Lumpsumscreen(),
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
        '/loginScreen': (context) => const Loginscreen(),
        '/signupScreen': (context) => const SignupScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
      },
    );
  }
  
  
  Future<void> _checkFirebaseInitialization() async {
    try {
      if (Firebase.apps.isEmpty) {
        throw Exception('Firebase not initialized');
      }
      print("✅ Firebase verification passed");
    } catch (e) {
      print("❌ Firebase verification failed: $e");
      rethrow;
    }
  }
}