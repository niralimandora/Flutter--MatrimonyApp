
import 'package:flutter/material.dart';
import 'package:untitled/Matrimonial%20App/DashboardScreen.dart';

import 'dart:async';






class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), (){
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => dashboardScreen()),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/Images/logo.jpeg'),
            backgroundColor: Colors.green,

            // child: Container(
            //   child: Center(
            //         child: Image.asset('assets/Images/logo.jpeg'),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}


