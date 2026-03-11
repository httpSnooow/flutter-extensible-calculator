import 'package:flutter/material.dart';
import '../../calculator/domain/operations/addition.dart';
import '../../calculator/domain/operations/subtraction.dart';
import '../../calculator/domain/operations/multiplication.dart';
import '../../calculator/domain/operations/division.dart';
import '../../calculator/domain/operations/sqrt.dart';
import '../domain/bhaskara_calculator.dart';
import 'bhaskara_formatter.dart';

class BhaskaraTab extends StatefulWidget {
  const BhaskaraTab({super.key});

  @override
  State<BhaskaraTab> createState() => _BhaskaraTabState();
}

class _BhaskaraTabState extends State<BhaskaraTab> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();

  late final BhaskaraCalculator _calculator;
  final _formatter = BhaskaraFormatter();

  FormattedBhaskaraResult? _result;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Instantiate dependencies (DI approach)
    // Normally this could come from a Service Locator (like Provider/GetIt)
    _calculator = BhaskaraCalculator(
      add: AdditionOperation(),
      sub: SubtractionOperation(),
      mul: MultiplicationOperation(),
      div: DivisionOperation(),
      sqrt: SqrtOperation(),
    );
  }

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
      final a = double.tryParse(_aController.text.replaceAll(',', '.')) ?? 0;
      final b = double.tryParse(_bController.text.replaceAll(',', '.')) ?? 0;
      final c = double.tryParse(_cController.text.replaceAll(',', '.')) ?? 0;

      FocusScope.of(context).unfocus();

      // 1. Calculate pure math result
      final mathResult = _calculator.calculate(a, b, c);

      // 2. Format result for UI
      setState(() {
        _result = _formatter.format(mathResult);
      });
    }
  }

  void _clear() {
    _aController.clear();
    _bController.clear();
    _cController.clear();
    setState(() {
      _result = null;
    });
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.numbers),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Obrigatório';
          }
          final number = double.tryParse(value.replaceAll(',', '.'));
          if (number == null) {
            return 'Número inválido';
          }
          if (label == 'Coeficiente "a" (ax²)' && number == 0) {
            return 'Não pode ser zero';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Fórmula de Bhaskara',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'ax² + bx + c = 0',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTextField('Coeficiente "a" (ax²)', _aController),
            _buildTextField('Coeficiente "b" (bx)', _bController),
            _buildTextField('Coeficiente "c" (c)', _cController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _clear,
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpar'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_result != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _result!.isSuccess
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _result!.isSuccess ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _result!.isSuccess ? Icons.check_circle : Icons.error,
                      color: _result!.isSuccess ? Colors.green : Colors.red,
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _result!.message,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
