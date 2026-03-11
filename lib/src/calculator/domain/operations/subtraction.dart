import '../operation.dart';

class SubtractionOperation extends Operation {
  @override
  String get symbol => '-';
  @override
  String get name => 'Subtraction';
  @override
  int get argCount => 1;

  @override
  double execute(double accumulator, [double? operand]) {
    return accumulator - (operand ?? 0);
  }
}
