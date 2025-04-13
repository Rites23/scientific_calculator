import 'package:flutter/material.dart';
import 'ui/calculator_screen.dart'; // Adjust the import path if needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(), // Ensure this import path is correct
    );
  }
}
