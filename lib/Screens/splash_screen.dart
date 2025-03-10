import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:organ_donation_app/users/loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  super.initState();
  Timer(const Duration(seconds: 5),
     () { 
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Loginpage(),));
     });
  
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(1, 31, 75, 1),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/Images/logo3.png",

              width: 300,

              ),
              
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                width: 90,
                height: 90,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid, /// Required, The loading type of the widget
                  colors: [Colors.white],
                  strokeWidth: 0.001,
                ),
              )
              
            ],
        ),
      ),
    );
  }
}