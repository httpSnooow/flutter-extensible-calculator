import '../domain/operation.dart';

class CalculatorState {
  final String display;
  final double? accumulator;
  final Operation? pendingOperation;
  final bool isNewNumber;

  CalculatorState({
    required this.display,
    this.accumulator,
    this.pendingOperation,
    this.isNewNumber = true,
  });

  CalculatorState copyWith({
    String? display,
    double? accumulator,
    Operation? pendingOperation,
    bool? isNewNumber,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      accumulator: accumulator ?? this.accumulator,
      pendingOperation: pendingOperation ?? this.pendingOperation,
      isNewNumber: isNewNumber ?? this.isNewNumber,
    );
  }

  factory CalculatorState.initial() {
    return CalculatorState(display: '0');
  }
}
