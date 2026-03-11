import 'dart:math' as math;
import '../operation.dart';

class SqrtOperation extends Operation {
  @override
  String get symbol => '√';
  @override
  String get name => 'Square Root';
  @override
  int get argCount => 0; // Unary operation

  @override
  double execute(double accumulator, [double? operand]) {
    if (accumulator < 0) throw Exception('Square root of negative number');
    return math.sqrt(accumulator);
  }
}
