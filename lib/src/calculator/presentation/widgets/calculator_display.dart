import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/calculator_engine.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorEngine>(
      builder: (context, engine, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.bottomRight,
          child: Text(
            engine.state.display,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
