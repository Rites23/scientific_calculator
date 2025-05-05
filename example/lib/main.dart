import 'package:flutter/material.dart';
import 'package:scientific_calculator/screens/calculator_screen.dart';

void main() {
  runApp(const CalculatorDemoApp());
}

class CalculatorDemoApp extends StatelessWidget {
  const CalculatorDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: const Center(
          child: CalculatorScreen(), // Use your actual calculator widget here
        ),
      ),
    );
  }
}

