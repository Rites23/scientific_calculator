📱 Flutter Scientific Calculator

https://github.com/user-attachments/assets/b346ac28-457d-4381-b79d-1a342f72910e

A simple yet powerful scientific calculator built using Flutter.

Supports basic, scientific, and trigonometric operations with the ability to toggle between Degrees and Radians modes for accurate trigonometric calculations.

✨ Features
Basic arithmetic (➕ ➖ ✖️ ➗)

Scientific functions:

Sine (sin)

Cosine (cos)

Tangent (tan)

Logarithm (log, ln)

Square root (√)

Exponents (x^y, e^x)

Degrees ↔ Radians toggle for trigonometric functions

Modern and responsive UI

Supports decimal numbers and negative values

🧠 Important Note About Trigonometric Functions
In Dart (dart:math library), all trigonometric functions (sin, cos, tan, etc.) expect the input in radians.

This means:

If the user inputs degrees (like sin(30) meaning 30 degrees), you must first convert it to radians before calling sin().

If the user is already in radians mode, no conversion is needed.

✅ This project correctly handles it:

When in Degrees mode, it automatically converts user input into radians before applying sin, cos, tan.

When in Radians mode, it passes the input directly to Dart's sin, cos, tan functions.


<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->


