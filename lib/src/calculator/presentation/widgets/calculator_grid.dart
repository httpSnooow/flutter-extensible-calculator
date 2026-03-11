import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/operation.dart';
import '../../domain/operations_registry.dart';
import '../../logic/calculator_engine.dart';
import 'operation_button.dart';

class CalculatorGrid extends StatelessWidget {
  const CalculatorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final registry = context.watch<OperationsRegistry>();
    final engine = context.read<CalculatorEngine>();

    final basicOps = registry.operations
        .where((op) => ['+', '-', '×', '÷'].contains(op.symbol))
        .toList();
    final extraOps = registry.operations
        .where((op) => !['+', '-', '×', '÷'].contains(op.symbol))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Pad
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: 4.0,
          padding: const EdgeInsets.all(4),
          children: [
            OperationButton(text: '7', onPressed: () => engine.addDigit(7)),
            OperationButton(text: '8', onPressed: () => engine.addDigit(8)),
            OperationButton(text: '9', onPressed: () => engine.addDigit(9)),
            OperationButton(
              text: 'C',
              color: Colors.orange[300],
              onPressed: engine.onClearPressed,
            ),

            OperationButton(text: '4', onPressed: () => engine.addDigit(4)),
            OperationButton(text: '5', onPressed: () => engine.addDigit(5)),
            OperationButton(text: '6', onPressed: () => engine.addDigit(6)),
            _buildOpButton(engine, basicOps, '+'),

            OperationButton(text: '1', onPressed: () => engine.addDigit(1)),
            OperationButton(text: '2', onPressed: () => engine.addDigit(2)),
            OperationButton(text: '3', onPressed: () => engine.addDigit(3)),
            _buildOpButton(engine, basicOps, '-'),

            OperationButton(text: '0', onPressed: () => engine.addDigit(0)),
            _buildOpButton(engine, basicOps, '×'),
            _buildOpButton(engine, basicOps, '÷'),
            OperationButton(
              text: '=',
              color: Colors.blue[300],
              onPressed: engine.onEqualsPressed,
            ),
          ],
        ),

        if (extraOps.isNotEmpty) ...[
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: extraOps.map((op) {
                return SizedBox(
                  width: 45,
                  height: 35,
                  child: OperationButton(
                    text: op.symbol,
                    color: Colors.grey[300],
                    onPressed: () => engine.onOperationPressed(op),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOpButton(
    CalculatorEngine engine,
    List<Operation> ops,
    String symbol,
  ) {
    Operation? op;
    try {
      op = ops.firstWhere((o) => o.symbol == symbol);
    } catch (_) {
      op = null;
    }

    return OperationButton(
      text: symbol,
      color: Colors.grey[400],
      onPressed: () => op != null ? engine.onOperationPressed(op) : null,
    );
  }
}
