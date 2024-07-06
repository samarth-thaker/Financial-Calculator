import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void sip() {
    Navigator.pushNamed(context, "/sipcalculator");
  }

  void lumpsum() {
    Navigator.pushNamed(context, "/siplumpsum");
  }

  void stepup() {
    Navigator.pushNamed(context, "/stepupSIP");
  }

  void fd() {
    Navigator.pushNamed(context, "/fixedDepositCalculator");
  }

  void rd() {
    Navigator.pushNamed(context, "/recDeposit");
  }

  void cagr() {
    Navigator.pushNamed(context, "/cagrCalc");
  }

  void fire() {
    Navigator.pushNamed(context, "/fireCalculator");
  }

  void goalLumpsum() {
    Navigator.pushNamed(context, "/goalLumpsum");
  }

  void goalSIP() {
    Navigator.pushNamed(context, "/goalSip");
  }

  void oneTime() {
    Navigator.pushNamed(context, "/timedurationLumpsum");
  }

  void regular() {
    Navigator.pushNamed(context, "/timedurationRegular");
  }

  void emiCalculation() {
    Navigator.pushNamed(context, "/emiCalc");
  }

  Widget customTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      title: Text(title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(249, 250, 200, 20))),
      leading: Icon(icon, size: 30, color: Color.fromARGB(249, 250, 200, 20)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(249, 250, 200, 20),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: Color.fromARGB(249, 0, 114, 188),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Calculator', 
      style: const TextStyle(
        color: Colors.black,
      )
      )),
      body:Container(
       /*  decoration: BoxDecoration(
          color: Color.fromARGB(249, 245, 237, 213)
        ), */
        child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            customTile("Lumpsum", Icons.monetization_on, lumpsum),
            const SizedBox(height: 10),
            customTile("SIP", Icons.account_balance_wallet, sip),
            const SizedBox(height: 10),
            customTile("Step up SIP", Icons.trending_up, stepup),
            const SizedBox(height: 10),
            customTile("Fixed Deposit", Icons.account_balance, fd),
            const SizedBox(height: 10),
            customTile("Recurring Deposit", Icons.repeat, rd),
            const SizedBox(height: 10),
            customTile("CAGR", Icons.bar_chart, cagr),
            const SizedBox(height: 10),
            customTile("FIRE", Icons.whatshot, fire),
            const SizedBox(height: 10),
            customTile("Goal Planning - Lumpsum", Icons.money, goalLumpsum),
            const SizedBox(height: 10),
            customTile(
                "Goal Planning - SIP", Icons.monetization_on_sharp, goalSIP),
            const SizedBox(height: 10),
            customTile(
                "Time Duration - One Time", Icons.punch_clock_rounded, oneTime),
            const SizedBox(height: 10),
            customTile("Time Duration - Regular", Icons.punch_clock, regular),
            const SizedBox(height: 10),
            customTile("EMI Calculator", Icons.money, emiCalculation)
          ],
        ),
      ),
      ),
     
    );
  }
}
