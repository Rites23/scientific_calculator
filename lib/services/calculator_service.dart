import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class CalculatorService {
  static double _memory = 0;
  static bool _isRadians = true;
  static double? _previousAnswer;
  static double? _prePreviousAnswer;

  

  static double evaluate(String expression) {
    try {
      // Handle memory operations first
    if (expression == "MC") {
      memoryClear();
      return 0;
    } else if (expression == "MR") {
      return _memory;
    } else if (expression.startsWith("M+")) {
      double value = double.tryParse(expression.substring(2)) ?? 0;
      memoryAdd(value);
      return _memory;
    } else if (expression.startsWith("M-")) {
      double value = double.tryParse(expression.substring(2)) ?? 0;
      memorySubtract(value);
      return _memory;
    } else if (expression.startsWith("MS")) {
      double value = double.tryParse(expression.substring(2)) ?? 0;
      memoryStore(value);
      return _memory;
    }

      String parsedExpr = _preprocessExpression(expression);
      // ignore: deprecated_member_use
      Parser p = Parser();
      Expression exp = p.parse(parsedExpr);
      
      ContextModel cm = ContextModel();
      cm.bindVariableName('pi', Number(math.pi));
      cm.bindVariableName('e', Number(math.e));

      // Trigonometric functions
      cm.bindFunctionName('sin', (args) => _trigFunction('sin', args[0]));
      cm.bindFunctionName('cos', (args) => _trigFunction('cos', args[0]));
      cm.bindFunctionName('tan', (args) => _trigFunction('tan', args[0]));
      
      // Inverse trigonometric
     cm.bindFunctionName('arcsin', (args) => _inverseTrigFunction('arsin', args[0]));
     cm.bindFunctionName('arccos', (args) => _inverseTrigFunction('arcos', args[0]));
     cm.bindFunctionName('arctan', (args) => _inverseTrigFunction('artan', args[0]));
      
      // Other functions
      cm.bindFunctionName('sqrt', (args) => math.sqrt(args[0]));
      cm.bindFunctionName('cbrt', (args) => math.pow(args[0], 1/3).toDouble());
      cm.bindFunctionName('log', (args) => math.log(args[0]) / math.ln10);
      cm.bindFunctionName('ln', (args) => math.log(args[0]));
      cm.bindFunctionName('factorial', (args) => _factorial(args[0]));
      cm.bindFunctionName('mod', (args) => args[0] % args[1]);

      double result = exp.evaluate(EvaluationType.REAL, cm);

      // Update answer history
      _prePreviousAnswer = _previousAnswer;
      _previousAnswer = result;

      return result;
    } catch (e) {
      throw Exception(_simplifyError(e.toString()));
    }
  }

  static String _preprocessExpression(String expr) {
  // Handle Ans and PreAns first
  String processed = expr
    .replaceAll('Ans', _previousAnswer?.toString() ?? '0')
    .replaceAll('PreAns', _prePreviousAnswer?.toString() ?? '0');

  // Handle memory recall
  processed = processed.replaceAll('MR', _memory.toString());

  // Handle trigonometric functions with degree conversion
  if (!_isRadians) {
    processed = processed.replaceAllMapped(RegExp(r'(sin|cos|tan)\(([^)]+)\)'), 
      (match) => '${match.group(1)}((${match.group(2)})*pi/180)');
  }

  
  // Handle inverse trigonometric functions with degree conversion
  if (!_isRadians) {
    processed = processed.replaceAllMapped(RegExp(r'(arc(?:sin|cos|tan))\(([^)]+)\)'), 
      (match) => '(${match.group(1)}(${match.group(2)}))*180/pi');
  }


  // Other replacements
  return processed
    .replaceAll('×', '*').replaceAll('x', '*')
    .replaceAll('÷', '/')
    .replaceAll('π', 'pi')
    .replaceAllMapped(RegExp(r'(\d+)!'), (m) => 'factorial(${m.group(1)})')
    .replaceAllMapped(RegExp(r'√\(([^)]+)\)'), (m) => 'sqrt(${m.group(1)})')
    .replaceAllMapped(RegExp(r'³√\(([^)]+)\)'), (m) => 'cbrt(${m.group(1)})')
    .replaceAllMapped(RegExp(r'mod\(([^)]+),([^)]+)\)'), 
      (m) => 'mod(${m.group(1)},${m.group(2)})');
}


  static double _trigFunction(String func, double value) {
    double radians = _isRadians ? value : value * math.pi / 180;
    switch (func) {
      case 'sin': return math.sin(radians);
      case 'cos': return math.cos(radians);
      case 'tan': return math.tan(radians);
      default: return value;
    }
  }

static double _inverseTrigFunction(String func, double value) {
  try {
    // First calculate the result in radians
    double resultRadians = switch (func) {
      'arcsin' => math.asin(value.clamp(-1, 1)),
      'arccos' => math.acos(value.clamp(-1, 1)),
      'arctan' => math.atan(value),
      _ => throw Exception('Unknown inverse trig function: $func'),
    };

    // Convert to degrees if needed
    return _isRadians ? resultRadians : resultRadians * 180 / math.pi;
  } catch (e) {
    throw Exception("Invalid input for $func");
  }
}

  
  


  static double _factorial(double n) {
    if (n < 0) throw Exception("Negative factorial");
    if (n.truncate() != n) throw Exception("Fractional factorial");
    if (n == 0 || n == 1) return 1;
    double result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  static String _simplifyError(String error) {
    if (error.contains("Division by zero")) return "Cannot divide by zero";
    if (error.contains("Domain error")) return "Invalid input for function";
    if (error.contains("Negative factorial")) return "Factorial of negative";
    if (error.contains("Fractional factorial")) return "Integer required";
    return "Invalid expression";
  }

      
      // Handle implied multiplication first (e.g., (2)(2) -> (2)*(2))
      
      String parsedExpr = expression.replaceAll('x', '*').replaceAll('×', '*');

      // First handle trigonometric functions with proper angle conversion
      parsedExpr = _convertTrigFunctions(parsedExpr);

      parsedExpr = _insertImpliedMultiplication(parsedExpr);

      // Replace UI symbols with math symbols and handle special cases
      parsedExpr = parsedExpr
          .replaceAll('÷', '/')
          .replaceAll('π', 'pi')
          .replaceAll('e', 'e')
          .replaceAll('^2', '^2')
          .replaceAll('^3', '^3')
          .replaceAll('mod', '%')
          .replaceAll('Ans', _previousAnswer?.toString() ?? '0')
          .replaceAll('PreAns', _prePreviousAnswer?.toString() ?? '0');

      // Handle special functions
      parsedExpr = _handleSpecialFunctions(parsedExpr);

      // Parse and evaluate
      // ignore: deprecated_member_use
      Parser p = Parser();
      Expression exp = p.parse(parsedExpr);
      ContextModel cm = ContextModel()
        ..bindFunctionName('sqrt', (args) => math.sqrt(args[0]))
        ..bindFunctionName('cbrt', (args) => math.pow(args[0], 1/3).toDouble())
        ..bindFunctionName('abs', (args) => args[0].abs())
        ..bindFunctionName('log', (args) => math.log(args[0]) / math.ln10)
        ..bindFunctionName('ln', (args) => math.log(args[0]))
        ..bindFunctionName('factorial', (args) => factorial(args[0]));

      double result = exp.evaluate(EvaluationType.REAL, cm);

      if (result.isInfinite) throw Exception('Division by zero');
      if (result.isNaN) throw Exception('Undefined result');

      // Update previous answers - enhanced from Ritesh's code
      _prePreviousAnswer = _previousAnswer;
      _previousAnswer = result;
// Track current input state

      return result;
    } catch (e) {
      throw _simplifyError(e);
    }
  }

  static String _convertTrigFunctions(String expr) {
  const trigFunctions = ['sin', 'cos', 'tan', 'asin', 'acos', 'atan'];
  
  for (var func in trigFunctions) {
    final pattern = RegExp('$func\\(([^)]+)\\)');
    expr = expr.replaceAllMapped(pattern, (match) {
      final value = match.group(1)!;
      // For inverse trig functions, we need to convert the result, not the input
      if (func.startsWith('a')) {
        return _isRadians 
            ? '$func($value)' 
            : '($func($value))*180/pi';
      } else {
        return _isRadians 
            ? '$func($value)' 
            : '$func(($value)*pi/180)';
      }
    });
  }
  return expr;
}


  // Added from Ritesh's code - improved trigonometric calculations
  static double calculateTrigonometric(String function, double value) {
    double radians = _isRadians ? value : value * math.pi / 180;
    switch (function) {
      case 'sin':
        return math.sin(radians);
      case 'cos':
        return math.cos(radians);
      case 'tan':
        return math.tan(radians);
      case 'asin':
        return math.asin(value);
      case 'acos':
        return math.acos(value);
      case 'atan':
        return math.atan(value);
      default:
        return value;
    }
  }

  // Added from Ritesh's code - better inverse trig handling
  static double calculateInverseTrigonometric(String function, double value) {
    double result = calculateTrigonometric(function, value);
    if (!_isRadians && function.startsWith('a')) {
      result = result * 180 / math.pi;
    }
    return result;
  }

  static Exception _simplifyError(dynamic e) {
    String message = e.toString();
    if (message.contains('Division by zero')) return Exception('Cannot divide by zero');
    if (message.contains('Mismatched')) return Exception('Mismatched parentheses');
    return Exception('Invalid expression');
  }

  static String _insertImpliedMultiplication(String expr) {
    // Handle cases like:
    // (2)(3) -> (2)*(3)
    // 2(3) -> 2*(3)
    // (2)3 -> (2)*3
    // 2π -> 2*π
    // π2 -> π*2
    
    // Insert multiplication between ) and (, ) and number, number and (, etc.
    final regex = RegExp(r'(\)\s*\(|\d\s*\(|\)\s*\d|\d\s*[a-zA-Zπ]|[a-zA-Zπ]\s*\d)');
    return expr.replaceAllMapped(regex, (match) {
      return match.group(0)!.replaceFirst(RegExp(r'(?<=\))\s*(?=\()|(?<=\d)\s*(?=\()|(?<=\))\s*(?=\d)|(?<=\d)\s*(?=[a-zA-Zπ])|(?<=[a-zA-Zπ])\s*(?=\d)'), '*');
    });
  }

  static String _handleSpecialFunctions(String expr) {
    // Handle square roots
    expr = expr.replaceAllMapped(RegExp(r'√\(([^)]+)\)'), 
        (match) => 'sqrt(${match.group(1)})');
    
    // Handle cube roots
    expr = expr.replaceAllMapped(RegExp(r'³√\(([^)]+)\)'), 
        (match) => 'cbrt(${match.group(1)})');
    
    // Handle absolute value
    expr = expr.replaceAllMapped(RegExp(r'abs\(([^)]+)\)'), 
        (match) => 'abs(${match.group(1)})');
    
    // Handle log base 10
    expr = expr.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), 
        (match) => 'log(${match.group(1)})');
    
    // Handle natural log
    expr = expr.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), 
        (match) => 'ln(${match.group(1)})');
    
    // Handle 10^x
    expr = expr.replaceAllMapped(RegExp(r'10\^\(([^)]+)\)'), 
        (match) => 'pow(10,${match.group(1)})');
    
    // Handle e^x
    expr = expr.replaceAllMapped(RegExp(r'e\^\(([^)]+)\)'), 
        (match) => 'exp(${match.group(1)})');
    
    // Handle factorial
    expr = expr.replaceAllMapped(RegExp(r'(\d+)!'), 
        (match) => 'factorial(${match.group(1)})');
    
    // Handle 1/x
    expr = expr.replaceAllMapped(RegExp(r'1\/\(([^)]+)\)'), 
        (match) => '(1/(${match.group(1)}))');
    
    return expr;
  }

  

  // Memory functions
  static double get memory => _memory;
  static void memoryAdd(double value) => _memory += value;
  static void memorySubtract(double value) => _memory -= value;
  static void memoryStore(double value) => _memory = value;
  static void memoryClear() => _memory = 0;

  // Angle mode
  static void toggleAngleMode() => _isRadians = !_isRadians;
  static bool get isRadians => _isRadians;

  // Special calculations
  static double factorial(double n) {
    if (n < 0) throw Exception("Negative factorial");
    if (n == 0 || n == 1) return 1;
    double result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  static memoryRecall() {}

  static evaluateExpression(String output, bool isRadians) {}


}

extension on ContextModel {
  void bindFunctionName(String s, double Function(dynamic args) param1) {}
}
