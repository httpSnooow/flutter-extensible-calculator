import 'package:flutter_test/flutter_test.dart';
import 'package:first_app_ueg_20261/src/bhaskara/domain/bhaskara_calculator.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/addition.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/subtraction.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/multiplication.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/division.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/sqrt.dart';

void main() {
  late BhaskaraCalculator calculator;

  setUp(() {
    calculator = BhaskaraCalculator(
      add: AdditionOperation(),
      sub: SubtractionOperation(),
      mul: MultiplicationOperation(),
      div: DivisionOperation(),
      sqrt: SqrtOperation(),
    );
  });

  group('BhaskaraCalculator Edge Cases', () {
    test('a = 0 should return notQuadratic', () {
      final result = calculator.calculate(0, 5, 2);
      expect(result.type, BhaskaraRootType.notQuadratic);
      expect(result.delta, isNull);
      expect(result.x1, isNull);
      expect(result.x2, isNull);
    });

    test('delta < 0 should return noRealRoots (e.g., 1x² + 2x + 5 = 0)', () {
      final result = calculator.calculate(1, 2, 5);
      expect(result.type, BhaskaraRootType.noRealRoots);
      expect(result.delta, -16.0); // 2*2 - 4*1*5 = 4 - 20 = -16
      expect(result.x1, isNull);
      expect(result.x2, isNull);
    });

    test('delta == 0 should return singleRoot (e.g., 1x² - 2x + 1 = 0)', () {
      final result = calculator.calculate(1, -2, 1);
      expect(result.type, BhaskaraRootType.singleRoot);
      expect(result.delta, 0.0); // (-2)*(-2) - 4*1*1 = 4 - 4 = 0

      // x = -(-2) / (2) = 1
      expect(result.x1, 1.0);
      expect(result.x2, 1.0);
    });

    test('delta > 0 should return twoRoots (e.g., 1x² - 3x + 2 = 0)', () {
      final result = calculator.calculate(1, -3, 2);
      expect(result.type, BhaskaraRootType.twoRoots);
      expect(result.delta, 1.0); // (-3)*(-3) - 4*1*2 = 9 - 8 = 1

      // x1 = (3 + 1) / 2 = 2
      // x2 = (3 - 1) / 2 = 1
      expect(result.x1, 2.0);
      expect(result.x2, 1.0);
    });

    test('decimals and fractional roots (e.g., 2.5x² + 5.5x - 3.2 = 0)', () {
      final result = calculator.calculate(2.5, 5.5, -3.2);
      expect(result.type, BhaskaraRootType.twoRoots);
      // delta = 5.5² - 4*2.5*(-3.2) = 30.25 + 32 = 62.25
      expect(result.delta, closeTo(62.25, 1e-4));

      // sqrt(62.25) ≈ 7.889866919
      // x1 = (-5.5 + 7.8898...) / 5 ≈ 0.47797
      // x2 = (-5.5 - 7.8898...) / 5 ≈ -2.67797

      expect(result.x1, closeTo(0.477973, 1e-5));
      expect(result.x2, closeTo(-2.677973, 1e-5));
    });

    test('large numbers to prevent overflow or weird precision issues', () {
      final result = calculator.calculate(1e10, 2e10, -3e10);
      // equivalent to 1x² + 2x - 3 = 0
      // delta = 4e20 - 4*(1e10)*(-3e10) = 4e20 + 12e20 = 16e20
      expect(result.type, BhaskaraRootType.twoRoots);
      expect(result.delta, 16e20);

      // x1 = (-2e10 + sqrt(16e20)) / 2e10 = (-2e10 + 4e10) / 2e10 = 2e10 / 2e10 = 1
      // x2 = (-2e10 - sqrt(16e20)) / 2e10 = (-2e10 - 4e10) / 2e10 = -6e10 / 2e10 = -3
      expect(result.x1, 1.0);
      expect(result.x2, -3.0);
    });

    test('very small numbers close to 0', () {
      final result = calculator.calculate(1e-10, -3e-10, 2e-10);
      // equivalent to 1x² - 3x + 2 = 0 (scale doesn't change roots)
      expect(result.type, BhaskaraRootType.twoRoots);
      // delta = 9e-20 - 4(1e-10)(2e-10) = 1e-20
      expect(result.delta, closeTo(1e-20, 1e-25));

      // Roots should still be 2 and 1
      expect(result.x1, closeTo(2.0, 1e-5));
      expect(result.x2, closeTo(1.0, 1e-5));
    });
  });
}
