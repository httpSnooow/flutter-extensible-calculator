import 'package:flutter_test/flutter_test.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operation.dart';
import 'package:first_app_ueg_20261/src/calculator/logic/calculator_engine.dart';

class MockAdd extends Operation {
  @override
  String get symbol => '+';
  @override
  String get name => 'Add';
  @override
  int get argCount => 1;
  @override
  double execute(double acc, [double? op]) => acc + (op ?? 0);
}

void main() {
  group('CalculatorEngine Tests', () {
    late CalculatorEngine engine;

    setUp(() {
      engine = CalculatorEngine();
    });

    test('Initial state is 0', () {
      expect(engine.state.display, '0');
    });

    test('Add digits updates display', () {
      engine.addDigit(1);
      engine.addDigit(2);
      expect(engine.state.display, '12');
    });

    test('Basic addition logic', () {
      engine.addDigit(5);
      engine.onOperationPressed(MockAdd());
      engine.addDigit(3);
      engine.onEqualsPressed();
      expect(engine.state.display, '8');
    });

    test('Clear resets state', () {
      engine.addDigit(5);
      engine.onClearPressed();
      expect(engine.state.display, '0');
    });
  });
}
