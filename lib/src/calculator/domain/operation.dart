abstract class Operation {
  /// The symbol to display on the calculator button (e.g., '+', 'x', '√').
  String get symbol;

  /// A descriptive name for the operation.
  String get name;

  /// The number of additional operands required.
  /// 0 for unary operations like '√' or '±'.
  /// 1 for binary operations like '+' or 'x'.
  int get argCount;

  /// Executes the mathematical logic.
  /// [accumulator] is the current value in the calculator.
  /// [operand] is the second value (only provided if [argCount] is 1).
  double execute(double accumulator, [double? operand]);
}
