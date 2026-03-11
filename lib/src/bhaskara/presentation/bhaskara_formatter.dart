import '../domain/bhaskara_calculator.dart';

class FormattedBhaskaraResult {
  final String message;
  final bool isSuccess;

  FormattedBhaskaraResult({required this.message, required this.isSuccess});
}

class BhaskaraFormatter {
  String _formatNumber(double n) {
    return n
        .toStringAsFixed(4)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  FormattedBhaskaraResult format(BhaskaraMathResult result) {
    switch (result.type) {
      case BhaskaraRootType.notQuadratic:
        return FormattedBhaskaraResult(
          message:
              'O coeficiente "a" não pode ser zero (não é equação do 2º grau).',
          isSuccess: false,
        );

      case BhaskaraRootType.noRealRoots:
        final deltaStr = _formatNumber(result.delta!);
        return FormattedBhaskaraResult(
          message: 'Delta = $deltaStr.\nA equação não possui raízes reais.',
          isSuccess: false,
        );

      case BhaskaraRootType.singleRoot:
        final deltaStr = _formatNumber(result.delta!);
        final xStr = _formatNumber(result.x1!);
        return FormattedBhaskaraResult(
          message:
              'Delta = $deltaStr.\nA equação possui uma raiz real dupla:\nx = $xStr',
          isSuccess: true,
        );

      case BhaskaraRootType.twoRoots:
        final deltaStr = _formatNumber(result.delta!);
        final x1Str = _formatNumber(result.x1!);
        final x2Str = _formatNumber(result.x2!);
        return FormattedBhaskaraResult(
          message: 'Delta = $deltaStr.\nRaízes:\nx1 = $x1Str\nx2 = $x2Str',
          isSuccess: true,
        );
    }
  }
}
