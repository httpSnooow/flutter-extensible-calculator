import '../operation.dart';

class DivisionOperation extends Operation {
  @override
  String get symbol => '÷';
  @override
  String get name => 'Division';
  @override
  int get argCount => 1;

  @override
  double execute(double accumulator, [double? operand]) {
    final divisor = operand ?? 0;
    if (divisor == 0) throw Exception('Division by zero');
    return accumulator / divisor;
  }
}
