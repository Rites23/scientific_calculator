import 'package:flutter/material.dart';
import '../../widgets/calc_button.dart';
import '../../logic/calculator_engine.dart';
import 'button_grid.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();
  String _display = '0';

  void _onDigitPressed(int digit) {
    setState(() {
      _engine.inputDigit(digit);
      _display = _engine.currentInput;
    });
  }

  void _onDecimalPressed() {
    setState(() {
      _engine.inputDecimal();
      _display = _engine.currentInput;
    });
  }

  void _onAddPressed() {
    setState(() {
      _engine.performOperation('+');
      _display = _engine.currentInput;
    });
  }

  void _onSubtractPressed() {
    setState(() {
      _engine.performOperation('-');
      _display = _engine.currentInput;
    });
  }

  void _onMultiplyPressed() {
    setState(() {
      _engine.performOperation('*');
      _display = _engine.currentInput;
    });
  }

  void _onDividePressed() {
    setState(() {
      _engine.performOperation('/');
      _display = _engine.currentInput;
    });
  }

  void _onEqualsPressed() {
    setState(() {
      _engine.calculateResult();
      _display = _engine.currentInput;
    });
  }

  void _onClearPressed() {
    setState(() {
      _engine.clear();
      _display = _engine.currentInput;
    });
  }

  void _onAllClearPressed() {
    setState(() {
      _engine.allClear();
      _display = _engine.currentInput;
    });
  }

  void _onToggleRadiansDegrees() {
    setState(() {
      _engine.toggleRadiansDegrees();
      // Optionally update the display to show the current mode
    });
  }

  void _onTrigonometricPressed(String function) {
    setState(() {
      _engine.performTrigonometric(function);
      _display = _engine.currentInput;
    });
  }

  void _onInverseTrigonometricPressed(String function) {
    setState(() {
      _engine.performInverseTrigonometric(function);
      _display = _engine.currentInput;
    });
  }

  void _onRecallAnsPressed() {
    setState(() {
      _engine.recallAns();
      _display = _engine.currentInput;
    });
  }

  void _onRecallPreAnsPressed() {
    setState(() {
      _engine.recallPreAns();
      _display = _engine.currentInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 60.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Divider(height: 1.0, color: Colors.grey),
          Expanded(
            flex: 2,
            child: ButtonGrid(
              onDigitPressed: _onDigitPressed,
              onDecimalPressed: _onDecimalPressed,
              onAddPressed: _onAddPressed,
              onSubtractPressed: _onSubtractPressed,
              onMultiplyPressed: _onMultiplyPressed,
              onDividePressed: _onDividePressed,
              onEqualsPressed: _onEqualsPressed,
              onClearPressed: _onClearPressed,
              onAllClearPressed: _onAllClearPressed,
              onToggleRadiansDegrees: _onToggleRadiansDegrees,
              onTrigonometricPressed: _onTrigonometricPressed,
              onInverseTrigonometricPressed: _onInverseTrigonometricPressed,
              onRecallAnsPressed: _onRecallAnsPressed,
              onRecallPreAnsPressed: _onRecallPreAnsPressed,
            ),
          ),
        ],
      ),
    );
  }
}
