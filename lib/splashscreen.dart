import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:note_worthy/showdata.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const Showdata(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001f31),
      body: Column(
        children: [
          const SizedBox(height: 120),
          Expanded(
            flex: 2,
            child: Center(
              child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/logo.jpeg')),
            ),
          ),
          const Expanded(
              child: Text(
            'Loading your worthy notes..!',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ))
        ],
      ),
    );
  }
}
