// lib/logic/calculator_engine.dart
import 'dart:math';

class CalculatorEngine {
  double _currentInput = 0;
  double _previousInput = 0;
  String _operation = '';
  double _result = 0;
  bool _useRadians = true;
  double _ans = 0;
  double _preAns = 0;
  bool _newInputStarted = false;

  String get currentInput => _currentInput.toString();
  bool get useRadians => _useRadians;
  String get ans => _ans.toString();
  String get preAns => _preAns.toString();

  void toggleRadiansDegrees() {
    _useRadians = !_useRadians;
  }

  double calculateTrigonometric(String function, double value) {
    double radians = _useRadians ? value : value * pi / 180;
    switch (function) {
      case 'sin':
        return sin(radians);
      case 'cos':
        return cos(radians);
      case 'tan':
        return tan(radians);
      case 'asin':
        return asin(value);
      case 'acos':
        return acos(value);
      case 'atan':
        return atan(value);
      default:
        return value;
    }
  }

  void performTrigonometric(String function) {
    _currentInput = calculateTrigonometric(function, _currentInput);
  }

  void performInverseTrigonometric(String function) {
    _currentInput = calculateTrigonometric(function, _currentInput);
    if (!_useRadians) {
      _currentInput = _currentInput * 180 / pi;
    }
  }

  void calculateSquareRoot() {
    if (_currentInput >= 0) {
      _currentInput = sqrt(_currentInput);
    } else {
      _currentInput = double.nan;
    }
  }

  void square() {
    _currentInput = _currentInput * _currentInput;
  }

  void cube() {
    _currentInput = _currentInput * _currentInput * _currentInput;
  }

  void powerOfY() {
    _previousInput = _currentInput;
    _currentInput = 0;
    _operation = '^';
    _newInputStarted = false;
  }

  void calculatePowerOfY() {
    _preAns = _ans;
    _result = pow(_previousInput, _currentInput).toDouble();
    _ans = _result;
    _currentInput = _result;
    _operation = '';
    _previousInput = 0;
    _newInputStarted = true;
  }

  void cubeRoot() {
    _currentInput = pow(_currentInput, 1 / 3).toDouble();
  }

  void nthRoot() {
    _previousInput = _currentInput;
    _currentInput = 0;
    _operation = 'ⁿ√';
    _newInputStarted = false;
  }

  void calculateNthRoot() {
    _preAns = _ans;
    if (_previousInput >= 0 || (1 / _currentInput).round() % 2 != 0) {
      _result = pow(_previousInput, 1 / _currentInput).toDouble();
    } else {
      _result = double.nan; // Handle negative base with even root
    }
    _ans = _result;
    _currentInput = _result;
    _operation = '';
    _previousInput = 0;
    _newInputStarted = true;
  }

  void inputDigit(int digit) {
    final currentInputString = _currentInput.toString();
    if (_newInputStarted || _currentInput == 0) {
      _currentInput = digit.toDouble();
      _newInputStarted = false;
    } else if (currentInputString.contains('.')) {
      _currentInput = double.parse('$currentInputString$digit');
    } else {
      _currentInput = double.parse(
        '${currentInputString.split('.').first}$digit.0',
      );
      if (_currentInput.truncateToDouble() == _currentInput) {
        _currentInput = _currentInput.truncateToDouble();
      }
    }
  }

  void inputDecimal() {
    if (!_currentInput.toString().contains('.')) {
      _currentInput = double.parse('$_currentInput.');
    }
  }

  void performOperation(String operation) {
    _previousInput = _currentInput;
    _currentInput = 0;
    _operation = operation;
    _newInputStarted = false;
  }

  void calculateResult() {
    _preAns = _ans;
    switch (_operation) {
      case '+':
        _result = _previousInput + _currentInput;
        break;
      case '-':
        _result = _previousInput - _currentInput;
        break;
      case '*':
        _result = _previousInput * _currentInput;
        break;
      case '/':
        if (_currentInput != 0) {
          _result = _previousInput / _currentInput;
        } else {
          _result = double.infinity;
        }
        break;
      case '^':
        calculatePowerOfY();
        break;
      case 'ⁿ√':
        calculateNthRoot();
        break;
      default:
        _result = _currentInput;
    }
    _ans = _result;
    _currentInput = _result;
    _operation = '';
    _previousInput = 0;
    _newInputStarted = true;
  }

  void clear() {
    _currentInput = 0;
    _newInputStarted = false;
  }

  void allClear() {
    _currentInput = 0;
    _previousInput = 0;
    _operation = '';
    _result = 0;
    _ans = 0;
    _preAns = 0;
    _newInputStarted = false;
  }

  void recallAns() {
    _currentInput = _ans;
    _newInputStarted = true;
  }

  void recallPreAns() {
    _currentInput = _preAns;
    _newInputStarted = true;
  }

  void toggleSign() {
    if (_currentInput != 0) {
      _currentInput *= -1;
    } else {
      _currentInput = -0.0; // Explicitly set to negative zero
    }
  }
}
