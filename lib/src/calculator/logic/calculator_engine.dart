import 'package:flutter/foundation.dart';
import '../domain/operation.dart';
import 'calculator_state.dart';

class CalculatorEngine extends ChangeNotifier {
  CalculatorState _state = CalculatorState.initial();

  CalculatorState get state => _state;

  void addDigit(int digit) {
    String newDisplay;
    if (_state.isNewNumber || _state.display == '0') {
      newDisplay = digit.toString();
    } else {
      newDisplay = _state.display + digit.toString();
    }

    _state = _state.copyWith(display: newDisplay, isNewNumber: false);
    notifyListeners();
  }

  void onOperationPressed(Operation operation) {
    if (operation.argCount == 0) {
      // Unary operation like sqrt or square
      final current = double.tryParse(_state.display) ?? 0;
      final result = operation.execute(current);
      _state = _state.copyWith(
        display: _formatResult(result),
        isNewNumber: true,
      );
    } else {
      // Binary operation
      if (_state.pendingOperation != null && !_state.isNewNumber) {
        _calculate();
      }

      _state = _state.copyWith(
        accumulator: double.tryParse(_state.display),
        pendingOperation: operation,
        isNewNumber: true,
      );
    }
    notifyListeners();
  }

  void onEqualsPressed() {
    _calculate();
    _state = _state.copyWith(
      pendingOperation: null,
      accumulator: null,
      isNewNumber: true,
    );
    notifyListeners();
  }

  void onClearPressed() {
    _state = CalculatorState.initial();
    notifyListeners();
  }

  void _calculate() {
    if (_state.pendingOperation == null || _state.accumulator == null) return;

    final current = double.tryParse(_state.display) ?? 0;
    try {
      final result = _state.pendingOperation!.execute(
        _state.accumulator!,
        current,
      );
      _state = _state.copyWith(display: _formatResult(result));
    } catch (e) {
      _state = _state.copyWith(display: 'Error');
    }
  }

  String _formatResult(double result) {
    if (result.isInfinite || result.isNaN) return 'Error';
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result.toString();
  }
}
