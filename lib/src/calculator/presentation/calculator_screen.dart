import 'package:flutter/material.dart';
import '../../bhaskara/presentation/bhaskara_tab.dart';
import 'widgets/calculator_display.dart';
import 'widgets/calculator_grid.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Extensible Calculator',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calculate), text: 'Calculadora'),
              Tab(icon: Icon(Icons.functions), text: 'Bhaskara'),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              // Calculadora Padrão
              SingleChildScrollView(
                child: Column(
                  children: [
                    CalculatorDisplay(),
                    Divider(height: 1),
                    CalculatorGrid(),
                  ],
                ),
              ),
              // Calculadora de Bhaskara
              BhaskaraTab(),
            ],
          ),
        ),
      ),
    );
  }
}
