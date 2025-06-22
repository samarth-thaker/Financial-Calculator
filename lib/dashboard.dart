import 'package:financial_calculator/widgets/customTile.dart';
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Financial Calculator', 
      style: const TextStyle(
        color: Colors.black,
      )
      )),
      body:Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Customtile(title: "Lumpsum",icon:  Icons.monetization_on,onTap:  lumpsum),
           const SizedBox(height: 10),
          Customtile(title: "SIP",icon:  Icons.account_balance_wallet,onTap:  sip),
          const SizedBox(height: 10),
          Customtile(title:"Step up SIP",icon: Icons.trending_up,onTap: stepup),
          const SizedBox(height: 10),
          Customtile(title:"Fixed Deposit",icon: Icons.account_balance,onTap: fd),
          const SizedBox(height: 10),
          Customtile(title:"Recurring Deposit",icon: Icons.repeat,onTap: rd),
          const SizedBox(height: 10),
          Customtile(title:"CAGR",icon: Icons.bar_chart,onTap: cagr),
          const SizedBox(height: 10),
          Customtile(title:"FIRE", icon:Icons.whatshot,onTap:  fire),
          const SizedBox(height: 10),
          Customtile(title:"Goal Planning - Lumpsum",icon: Icons.money,onTap:  goalLumpsum),
          const SizedBox(height: 10),
         Customtile(
        title: "Goal Planning - SIP",
        icon: Icons.monetization_on_sharp,
        onTap: goalSIP,
      ),
      
          const SizedBox(height: 10),
          Customtile(title:
              "Time Duration - One Time",icon: Icons.punch_clock_rounded,onTap:  oneTime),
          const SizedBox(height: 10),
          Customtile(title:"Time Duration - Regular",icon: Icons.punch_clock,onTap:  regular),
          const SizedBox(height: 10),
          Customtile(title:"EMI Calculator",icon: Icons.money,onTap:  emiCalculation)
           
        ],
      ),
            ),
     
    );
  }
}