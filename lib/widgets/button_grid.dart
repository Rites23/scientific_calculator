import 'package:flutter/material.dart';
import 'package:scientific_calculator/widgets/custom_button.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final bool isRadians;

  const ButtonGrid({
    super.key,
    required this.onButtonPressed,
    required this.isRadians,
  });

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView(
  
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10,),
        // First Grid (Memory + Trig buttons - short height)
        GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 6,
          childAspectRatio: 1.8, // Makes buttons wider and shorter
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            // Row 1: Memory functions
            _memoryButton("MS"),
            _memoryButton("MR"),
            _memoryButton("M+"),
            _memoryButton("M-"),
            _radDegToggle(),
            
            
            // Row 2: Trigonometric functions
            _trigButton("sin"),
            _trigButton("cos"),
            _trigButton("tan"),
            _trigInverseButton("sin⁻¹"),
            _trigButton("%"),

            // Row 8: Logarithms and constants
            _logButton("log"),
            _logButton("ln"),
            _logButton("e^"),
            _trigInverseButton("cos⁻¹"),
            _trigInverseButton("tan⁻¹"),
            
        
            // Row 9: Advanced functions
            _advancedButton("|x|"),
            _advancedButton("1/x"),
            _advancedButton("10^"),
            _constantButton("π"),
            _constantButton("e"),

            // Row 7: Powers and roots
            _powerButton("x²"),
            _powerButton("x³"),
            _powerButton("^"),
            _rootButton("√"),
            _rootButton("³√"),
        
        
            // Row 10: Parentheses and mod
            _parenthesisButton("("),
            _parenthesisButton(")"),
            _modButton(),
            _functionButton("!"),
            _answerButton("PreAns"),
          ],
        ),
        
        // Second Grid (All other buttons - normal height)
        SizedBox(height: 15,),
        GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 6,
          childAspectRatio: 0.85, // Square-ish buttons
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          
          children: [
            // Number and operation buttons...
            _numberButton("7"),
            _numberButton("8"),
            _numberButton("9"),
            _clearButton("AC"),
            _backspaceButton(),
            
            // Row 3: Numbers and operations
            _numberButton("4"),
            _numberButton("5"),
            _numberButton("6"),
            _operationButton("x"),
            _operationButton("÷"),
        
            // Row 4: Numbers and operations
            _numberButton("1"),
            _numberButton("2"),
            _numberButton("3"),
            _operationButton("-"),
            _operationButton("+"),
        
            // Row 5: Bottom row with special buttons
            _numberButton("0"),
            _decimalButton(),
            _signButton(),
            _answerButton("Ans"),
            _equalsButton(),
        
            
          ],
        ),
      ],
    ),
  );
}

// Helper methods with updated height control
Widget _memoryButton(String text) => _buildShortButton(
  text: text,
  onPressed: () => onButtonPressed(text),
  backgroundColor: Colors.grey[300],
);

Widget _trigButton(String text) => _buildShortButton(
  text: text,
  onPressed: () => onButtonPressed("$text("),
);

Widget _buildShortButton({
  required String text,
  required VoidCallback onPressed,
  Color? backgroundColor,
  
}) {
  return SizedBox(
    height: 40, // Fixed short height
    child: CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      isSmall: true,
    ),
  );
}

  


  // Helper methods for different button types

  Widget _clearButton(String text) => CustomButton(
        text: text,
        onPressed: () => onButtonPressed(text),
        backgroundColor: Colors.deepOrange[200]!,
      );

  Widget _numberButton(String text) => CustomButton(
        text: text,
        onPressed: () => onButtonPressed(text),
      );

  Widget _operationButton(String text) => CustomButton(
        text: text,
        onPressed: () => onButtonPressed(text),
        backgroundColor: Colors.blue[100]!,
      );

  Widget _backspaceButton() => CustomButton(
        text: "DEL",
        onPressed: () => onButtonPressed("⌫"),
        backgroundColor: Colors.deepOrange[200]!,
      );

  Widget _functionButton(String text) => CustomButton(
        text: text,
        onPressed: () => onButtonPressed(text),
      );

  Widget _decimalButton() => CustomButton(
        text: ".",
        onPressed: () => onButtonPressed("."),
      );

  Widget _signButton() => CustomButton(
        text: "±",
        onPressed: () => onButtonPressed("±"),
      );

  Widget _equalsButton() => CustomButton(
        text: "=",
        onPressed: () => onButtonPressed("="),
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );


  Widget _trigInverseButton(String text) => _buildShortButton(
  text: text,
  onPressed: () {
    final funcName = switch(text) {
      'sin⁻¹' => 'arcsin(',
      'cos⁻¹' => 'arccos(',
      'tan⁻¹' => 'arctan(',
      _ => 'arsin(' // default case
    };
    onButtonPressed(funcName);
  },
);

  Widget _radDegToggle() => _buildShortButton(
        text: isRadians ? "DEG" : "RAD",
        onPressed: () => onButtonPressed("Rad"),
        backgroundColor: const Color(0xFF607D8B),
      );

  Widget _powerButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed(text == "^" ? "^" : "${text == "x²" ? "^2" : "^3"}"),
      );

  Widget _rootButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed("${text == "√" ? "√(" : "∛("}"),
      );

  Widget _logButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed("${text}("),
      );

  Widget _constantButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed(text),
      );

  Widget _advancedButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed(text == "|x|" ? "abs(" : text == "1/x" ? "1/(" : "10^("),
      );

  Widget _parenthesisButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed(text),
      );

  Widget _modButton() => _buildShortButton(
        text: "mod",
        onPressed: () => onButtonPressed("mod("),
      );

  Widget _answerButton(String text) => _buildShortButton(
        text: text,
        onPressed: () => onButtonPressed(text),
      );
}
