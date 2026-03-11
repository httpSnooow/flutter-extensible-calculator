import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/calculator/domain/operations_registry.dart';
import 'src/calculator/domain/operations/addition.dart';
import 'src/calculator/domain/operations/subtraction.dart';
import 'src/calculator/domain/operations/multiplication.dart';
import 'src/calculator/domain/operations/division.dart';
import 'src/calculator/domain/operations/sqrt.dart';
import 'src/calculator/logic/calculator_engine.dart';
import 'src/calculator/presentation/calculator_screen.dart';

void main() {
  final registry = OperationsRegistry()
    ..register(AdditionOperation())
    ..register(SubtractionOperation())
    ..register(MultiplicationOperation())
    ..register(DivisionOperation())
    ..register(SqrtOperation());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: registry),
        ChangeNotifierProvider(create: (_) => CalculatorEngine()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Extensible Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.remember_me),
            onPressed: _resetCounter,
            tooltip: 'Zerar Contador',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Você apertou o botão tantas vezes:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
