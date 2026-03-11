import '../operation.dart';

class MultiplicationOperation extends Operation {
  @override
  String get symbol => '×';
  @override
  String get name => 'Multiplication';
  @override
  int get argCount => 1;

  @override
  double execute(double accumulator, [double? operand]) {
    return accumulator * (operand ?? 0);
  }
}
