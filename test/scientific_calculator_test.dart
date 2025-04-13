// test/scientific_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/logic/calculator_engine.dart';
import 'dart:math';

void main() {
  group('CalculatorEngine Basic Arithmetic', () {
    final engine = CalculatorEngine();

    setUp(() {
      engine.allClear(); // Reset engine before each test
    });

    test('should add two numbers correctly', () {
      engine.inputDigit(5);
      engine.performOperation('+');
      engine.inputDigit(3);
      engine.calculateResult();
      expect(engine.currentInput, '8.0');
    });

    test('should subtract two numbers correctly', () {
      engine.inputDigit(10);
      engine.performOperation('-');
      engine.inputDigit(4);
      engine.calculateResult();
      expect(engine.currentInput, '6.0');
    });

    test('should multiply two numbers correctly', () {
      engine.inputDigit(7);
      engine.performOperation('*');
      engine.inputDigit(6);
      engine.calculateResult();
      expect(engine.currentInput, '42.0');
    });

    test('should divide two numbers correctly', () {
      engine.inputDigit(12);
      engine.performOperation('/');
      engine.inputDigit(3);
      engine.calculateResult();
      expect(engine.currentInput, '4.0');
    });

    test('should handle division by zero', () {
      engine.inputDigit(10);
      engine.performOperation('/');
      engine.inputDigit(0);
      engine.calculateResult();
      expect(engine.currentInput, 'Infinity'); // Or your expected error string
    });

    test('should handle decimal input correctly', () {
      engine.inputDigit(1);
      engine.inputDecimal();
      engine.inputDigit(5);
      expect(engine.currentInput, '1.5');
    });

    test('should clear the current input', () {
      engine.inputDigit(123);
      engine.clear();
      expect(engine.currentInput, '0.0');
    });

    test('should perform all clear', () {
      engine.inputDigit(5);
      engine.performOperation('+');
      engine.inputDigit(3);
      engine.calculateResult();
      engine.allClear();
      engine.inputDigit(1);
      expect(engine.currentInput, '1.0');
    });
  });

  group('CalculatorEngine Trigonometric Functions', () {
    final engine = CalculatorEngine();

    setUp(() {
      engine.allClear();
      engine
          .toggleRadiansDegrees(); // Set to radians by default for these tests
    });

    test('should calculate sin in radians', () {
      engine.inputDecimal();
      engine.inputDigit(1);
      engine.inputDigit(5);
      engine.inputDigit(7);
      engine.performTrigonometric('sin');
      expect(double.parse(engine.currentInput), closeTo(sin(1.57), 1e-7));
    });

    test('should calculate cos in degrees', () {
      engine.toggleRadiansDegrees(); // Set to degrees
      engine.inputDigit(0);
      engine.performTrigonometric('cos');
      expect(double.parse(engine.currentInput), closeTo(1.0, 1e-10));
    });

    test('should calculate asin in radians', () {
      engine.inputDecimal();
      engine.inputDigit(8);
      engine.performInverseTrigonometric('asin');
      expect(double.parse(engine.currentInput), closeTo(asin(0.8), 1e-7));
    });

    test('should calculate acos in degrees', () {
      engine.toggleRadiansDegrees(); // Set to degrees
      engine.inputDecimal();
      engine.inputDigit(5);
      engine.performInverseTrigonometric('acos');
      expect(
        double.parse(engine.currentInput),
        closeTo(acos(0.5) * 180 / pi, 1e-7),
      );
    });
  });

  group('CalculatorEngine Ans/PreAns', () {
    final engine = CalculatorEngine();

    setUp(() {
      engine.allClear();
    });

    test('should store and recall Ans', () {
      engine.inputDigit(5);
      engine.performOperation('+');
      engine.inputDigit(3);
      engine.calculateResult();
      engine.recallAns();
      expect(engine.currentInput, '8.0');
    });

    test('should store and recall PreAns', () {
      engine.inputDigit(2);
      engine.performOperation('*');
      engine.inputDigit(4);
      engine.calculateResult(); // Ans = 8
      engine.inputDigit(10);
      engine.performOperation('-');
      engine.inputDigit(2);
      engine.calculateResult(); // Ans = 8, PreAns = 8
      engine.recallPreAns();
      expect(engine.currentInput, '8.0');
    });
  });

  group('CalculatorEngine Square Root', () {
    final engine = CalculatorEngine();

    setUp(() {
      engine.allClear();
    });

    test('should calculate square root of a positive number', () {
      engine.inputDigit(9);
      engine.calculateSquareRoot();
      expect(engine.currentInput, '3.0');
    });

    test('should handle square root of zero', () {
      engine.inputDigit(0);
      engine.calculateSquareRoot();
      expect(engine.currentInput, '0.0');
    });

    test('should handle square root of a negative number', () {
      engine.inputDigit(9);
      engine.toggleSign();
      engine.calculateSquareRoot();
      expect(double.parse(engine.currentInput).isNaN, true);
    });
  });

  group('CalculatorEngine Exponent Functions', () {
    final engine = CalculatorEngine();

    setUp(() {
      engine.allClear();
    });

    test('should calculate square', () {
      engine.inputDigit(5);
      engine.square();
      expect(engine.currentInput, '25.0');
    });

    test('should calculate cube', () {
      engine.inputDigit(3);
      engine.cube();
      expect(engine.currentInput, '27.0');
    });

    test('should calculate power of y', () {
      engine.inputDigit(2);
      engine.powerOfY();
      engine.inputDigit(3);
      engine.calculateResult();
      expect(engine.currentInput, '8.0');
    });

    test('should calculate power of y with decimal exponent', () {
      engine.inputDigit(4);
      engine.powerOfY();
      engine.inputDecimal();
      engine.inputDigit(5);
      engine.calculateResult();
      expect(double.parse(engine.currentInput), closeTo(pow(4, 0.5), 1e-7));
    });

    test('should calculate cube root of a positive number', () {
      engine.inputDigit(27);
      engine.cubeRoot();
      expect(double.parse(engine.currentInput), closeTo(3.0, 1e-7));
    });

    test('should calculate cube root of a negative number', () {
      engine.inputDigit(8);
      engine.toggleSign();
      engine.cubeRoot();
      expect(double.parse(engine.currentInput), closeTo(-2.0, 1e-7));
    });

    test('should calculate nth root (integer root)', () {
      engine.inputDigit(16);
      engine.nthRoot();
      engine.inputDigit(2);
      engine.calculateResult();
      expect(engine.currentInput, '4.0');
    });

    test('should calculate nth root (decimal root)', () {
      engine.inputDigit(9);
      engine.nthRoot();
      engine.inputDecimal();
      engine.inputDigit(5);
      engine.calculateResult();
      expect(double.parse(engine.currentInput), closeTo(pow(9, 1 / 0.5), 1e-7));
    });

    test('should handle nth root of negative base with even root', () {
      engine.inputDigit(16);
      engine.toggleSign();
      engine.nthRoot();
      engine.inputDigit(2);
      engine.calculateResult();
      expect(double.parse(engine.currentInput).isNaN, true);
    });
  });
}
