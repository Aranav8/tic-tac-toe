import 'package:flutter/material.dart';
import 'package:tick_tac_toe/screens/intro_screen.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
    );
  }
}
