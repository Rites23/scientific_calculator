import 'package:flutter/material.dart';
import 'package:scientific_calculator/models/calculator_state.dart';
import 'package:scientific_calculator/services/calculator_service.dart';
import 'package:scientific_calculator/widgets/button_grid.dart';
import 'package:scientific_calculator/widgets/display_panel.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  CalculatorState _state = CalculatorState(
    output: "0",
    history: "",
    fontSize: 48,
    isRadians: false,
  );

  void _buttonPressed(String buttonText) {
  setState(() {
    try {
      if (buttonText == "C") {
        _state = _state.copyWith(output: "0", history: "");
      } 
      else if (buttonText == "AC") {
        _state = CalculatorState(output: "0", history: "", fontSize: 48);
        CalculatorService.memoryClear();
      }
      else if (buttonText == "⌫") {
        _state = _state.copyWith(
          output: _state.output.length > 1 
              ? _state.output.substring(0, _state.output.length - 1) 
              : "0",
        );
      }
      else if (buttonText == "Rad") {
        CalculatorService.toggleAngleMode();
        _state = _state.copyWith(isRadians: CalculatorService.isRadians);
      }
      else if (buttonText == "=") {
        double result = CalculatorService.evaluate(_state.output);
        _state = _state.copyWith(
          output: _formatResult(result),
          history: _state.output,
          previousResult: result,
        );
      }
      else if (buttonText == "Ans") {
        if (_state.previousResult != null) {
          _state = _state.copyWith(
            output: _state.output == "0" 
                ? _formatResult(_state.previousResult!)
                : _state.output + _formatResult(_state.previousResult!),
          );
        }
      }
      else if (buttonText == "x²") {
        _state = _state.copyWith(output: _state.output + "^2");
      }
      else if (buttonText == "x³") {
        _state = _state.copyWith(output: _state.output + "^3");
      }
      else if (buttonText == "nCr") {
        _state = _state.copyWith(output: _state.output + "C");
      }
      else if (buttonText == "nPr") {
        _state = _state.copyWith(output: _state.output + "P");
      }
      else if (buttonText == "!") {
        double value = double.parse(_state.output);
        double result = CalculatorService.factorial(value);
        _state = _state.copyWith(
          output: _formatResult(result),
          history: "$value!",
        );
      }
      else {
        _state = _state.copyWith(
          output: _state.output == "0" ? buttonText : _state.output + buttonText,
        );
      }

      // Adjust font size
      
      _state = _state.copyWith(fontSize: 8);
    } catch (e) {
      _state = _state.copyWith(output: "Error: ${e.toString()}");
    }
  });
}

String _formatResult(double result) {
  // Remove trailing .0 for whole numbers
  return result % 1 == 0 ? result.toInt().toString() : result.toString();
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 38),
          DisplayPanel(state: _state),
          //const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ButtonGrid(
                onButtonPressed: _buttonPressed,
                isRadians: _state.isRadians,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
