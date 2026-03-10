import '../../calculator/domain/operation.dart';

enum BhaskaraRootType {
  notQuadratic, // a == 0
  noRealRoots, // delta < 0
  singleRoot, // delta == 0
  twoRoots, // delta > 0
}

class BhaskaraMathResult {
  final BhaskaraRootType type;
  final double? delta;
  final double? x1;
  final double? x2;

  BhaskaraMathResult({required this.type, this.delta, this.x1, this.x2});
}

class BhaskaraCalculator {
  // Dependencies injected via constructor
  final Operation add;
  final Operation sub;
  final Operation mul;
  final Operation div;
  final Operation sqrt;

  BhaskaraCalculator({
    required this.add,
    required this.sub,
    required this.mul,
    required this.div,
    required this.sqrt,
  });

  BhaskaraMathResult calculate(double a, double b, double c) {
    if (a == 0) {
      return BhaskaraMathResult(type: BhaskaraRootType.notQuadratic);
    }

    // delta = b*b - 4*a*c
    final bSquared = mul.execute(b, b);
    final fourAC = mul.execute(4, mul.execute(a, c));
    final delta = sub.execute(bSquared, fourAC);

    if (delta < 0) {
      return BhaskaraMathResult(
        type: BhaskaraRootType.noRealRoots,
        delta: delta,
      );
    } else if (delta == 0) {
      // x = -b / (2 * a)
      final twoA = mul.execute(2, a);
      final minusB = sub.execute(0, b);
      final x = div.execute(minusB, twoA);

      return BhaskaraMathResult(
        type: BhaskaraRootType.singleRoot,
        delta: delta,
        x1: x,
        x2: x,
      );
    } else {
      // x1 = (-b + sqrt(delta)) / (2 * a)
      // x2 = (-b - sqrt(delta)) / (2 * a)
      final rootDelta = sqrt.execute(delta);
      final twoA = mul.execute(2, a);
      final minusB = sub.execute(0, b);

      final num1 = add.execute(minusB, rootDelta);
      final num2 = sub.execute(minusB, rootDelta);

      final x1 = div.execute(num1, twoA);
      final x2 = div.execute(num2, twoA);

      return BhaskaraMathResult(
        type: BhaskaraRootType.twoRoots,
        delta: delta,
        x1: x1,
        x2: x2,
      );
    }
  }
}
