import '../../widgets/calc_button.dart';
import 'package:flutter/material.dart';

class ButtonGrid extends StatelessWidget {
  final Function(int) onDigitPressed;
  final VoidCallback onDecimalPressed;
  final VoidCallback onAddPressed;
  final VoidCallback onSubtractPressed;
  final VoidCallback onMultiplyPressed;
  final VoidCallback onDividePressed;
  final VoidCallback onEqualsPressed;
  final VoidCallback onClearPressed; // Now for single clear
  final VoidCallback onAllClearPressed; // New callback for all clear
  final VoidCallback onToggleRadiansDegrees;
  final Function(String) onTrigonometricPressed;
  final Function(String) onInverseTrigonometricPressed;
  final VoidCallback onRecallAnsPressed; // New callback for Ans
  final VoidCallback onRecallPreAnsPressed; // New callback for PreAns

  const ButtonGrid({
    super.key,
    required this.onDigitPressed,
    required this.onDecimalPressed,
    required this.onAddPressed,
    required this.onSubtractPressed,
    required this.onMultiplyPressed,
    required this.onDividePressed,
    required this.onEqualsPressed,
    required this.onClearPressed, // Now for single clear
    required this.onAllClearPressed, // New callback for all clear
    required this.onToggleRadiansDegrees,
    required this.onTrigonometricPressed,
    required this.onInverseTrigonometricPressed,
    required this.onRecallAnsPressed, // Add this
    required this.onRecallPreAnsPressed, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: <Widget>[
        CalcButton(
          text: '7',
          onPressed: () => onDigitPressed(7),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '8',
          onPressed: () => onDigitPressed(8),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '9',
          onPressed: () => onDigitPressed(9),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: 'AC',
          onPressed: onAllClearPressed,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        ), // All Clear
        CalcButton(
          text: '4',
          onPressed: () => onDigitPressed(4),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '5',
          onPressed: () => onDigitPressed(5),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '6',
          onPressed: () => onDigitPressed(6),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '*',
          onPressed: onMultiplyPressed,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
        ),
        CalcButton(
          text: '1',
          onPressed: () => onDigitPressed(1),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '2',
          onPressed: () => onDigitPressed(2),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '3',
          onPressed: () => onDigitPressed(3),
          backgroundColor: Colors.grey[300],
        ),
        CalcButton(
          text: '-',
          onPressed: onSubtractPressed,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
        ),
        CalcButton(text: '0', onPressed: () => onDigitPressed(0)),
        CalcButton(text: '.', onPressed: onDecimalPressed),
        CalcButton(
          text: '=',
          onPressed: onEqualsPressed,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 24.0,
        ),
        CalcButton(
          text: '+',
          onPressed: onAddPressed,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
        ),
        CalcButton(
          text: '/',
          onPressed: onDividePressed,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
        ),
        CalcButton(
          text: 'DEG/RAD',
          onPressed: onToggleRadiansDegrees,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 16.0,
        ),
        CalcButton(
          text: 'sin',
          onPressed: () => onTrigonometricPressed('sin'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0,
        ),
        CalcButton(
          text: 'cos',
          onPressed: () => onTrigonometricPressed('cos'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0,
        ),
        CalcButton(
          text: 'tan',
          onPressed: () => onTrigonometricPressed('tan'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0,
        ),
        CalcButton(
          text: 'sin⁻¹',
          onPressed: () => onInverseTrigonometricPressed('asin'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 14.0,
        ),
        CalcButton(
          text: 'cos⁻¹',
          onPressed: () => onInverseTrigonometricPressed('acos'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 14.0,
        ),
        CalcButton(
          text: 'tan⁻¹',
          onPressed: () => onInverseTrigonometricPressed('atan'),
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 14.0,
        ),
        CalcButton(
          text: 'C',
          onPressed: onClearPressed,
          backgroundColor: Colors.orange[300],
          textColor: Colors.white,
        ), // Single Clear
        CalcButton(
          text: 'Ans',
          onPressed: onRecallAnsPressed,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 16.0,
        ),
        CalcButton(
          text: 'PreAns',
          onPressed: onRecallPreAnsPressed,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 14.0,
        ),
      ],
    );
  }
}
