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
  CalculatorState _state = const CalculatorState();

  void _buttonPressed(String buttonText) {
    setState(() {
      try {
        String newOutput = _state.output;
      String newHistory = _state.history;

      switch (buttonText) {
        case "C":
          newOutput = "0";
          newHistory = "";
          break;
        case "AC":
          _state = const CalculatorState();
          CalculatorService.memoryClear();
          return;
        case "⌫":
          newOutput = newOutput.length > 1 
              ? newOutput.substring(0, newOutput.length - 1) 
              : "0";
          break;
        case "Rad":
          CalculatorService.toggleAngleMode();
          _state = _state.copyWith(isRadians: CalculatorService.isRadians);
          return;
        case "=":
          double result = CalculatorService.evaluate(_state.output);
          newOutput = _formatResult(result);
          newHistory = _state.output;
          break;
        case "MC":
          CalculatorService.memoryClear();
          _state = _state.copyWith(memoryValue: 0);
          return;
        case "MR":
          newOutput = CalculatorService.memory.toString();
          break;
        case "M+":
          double currentValue = double.tryParse(_state.output) ?? 0;
          CalculatorService.memoryAdd(currentValue);
          _state = _state.copyWith(
          memoryValue: CalculatorService.memory,
          output: _state.output, // Keep current output
          );
          return;
        case "M-":
          double currentValue = double.tryParse(_state.output) ?? 0;
          CalculatorService.memorySubtract(currentValue);
          _state = _state.copyWith(
          memoryValue: CalculatorService.memory,
          output: _state.output, // Keep current output
          );
          return;
        case "MS":
          double currentValue = double.tryParse(_state.output) ?? 0;
          CalculatorService.memoryStore(currentValue);
          _state = _state.copyWith(
          memoryValue: currentValue,
          output: _state.output, // Keep current output
          );
          return;
        case "sin":
        case "cos":
        case "tan":
          newOutput = _state.output == "0" 
              ? "$buttonText(0)" 
              : "$buttonText($_state.output)";
          break;
        case "sin⁻¹":
          newOutput = "arcsin(${_state.output == "0" ? "" : _state.output})";
          break;
        case "cos⁻¹":
          newOutput = "arccos(${_state.output == "0" ? "" : _state.output})";
          break;
        case "tan⁻¹":
          newOutput = "arctan(${_state.output == "0" ? "" : _state.output})";
          break;
        case "log":
          newOutput = "log(${_state.output == "0" ? "" : _state.output})";
          break;
        case "ln":
          newOutput = "ln(${_state.output == "0" ? "" : _state.output})";
          break;
        case "√":
          newOutput = "√(${_state.output == "0" ? "" : _state.output})";
          break;
        case "³√":
          newOutput = "³√(${_state.output == "0" ? "" : _state.output})";
          break;
        case "x²":
          newOutput = "${_state.output == "0" ? "" : _state.output}^2";
          break;
        case "x³":
          newOutput = "${_state.output == "0" ? "" : _state.output}^3";
          break;
        case "!":
          newOutput = "${_state.output == "0" ? "" : _state.output}!";
          break;  
        
        default:
          newOutput = _state.output == "0" ? buttonText : _state.output + buttonText;
      }

        _state = _state.copyWith(
          output: newOutput,
          history: newHistory,
          fontSize: _calculateFontSize(newOutput),
        );
      } catch (e) {
        _state = _state.copyWith(output: "Error: ${e.toString().replaceAll('Exception: ', '')}");
      }
    });
  }

  String _formatResult(double result) {
    String formatted;
    if (result % 1 == 0) {
      formatted = result.toInt().toString();
    } else {
      formatted = result.toStringAsFixed(6);
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    }
    return formatted;
  }

  double _calculateFontSize(String text) {
    const double baseSize = 48;
    const int maxLength = 10;
    return text.length > maxLength ? baseSize * 0.8 : baseSize;
  }
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
