import 'package:flutter/material.dart';
import 'package:scientific_calculator/models/calculator_state.dart';
import 'package:scientific_calculator/widgets/display_container.dart';

class DisplayPanel extends StatelessWidget {
  final CalculatorState state;

  const DisplayPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return DisplayContainer(
      history: state.history,
      output: state.output,
      fontSize: state.fontSize,
    );
  }
}