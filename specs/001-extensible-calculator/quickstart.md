# Quickstart: Extending the Calculator

This project is designed to be extensible. You can add new operations without touching the UI code.

## How to add a new operation

1.  **Create a New Class**: Create a new file in `lib/src/calculator/domain/operations/`.
2.  **Implement the Interface**: Inherit from the `Operation` abstract class.
3.  **Define Logic**: Implement `symbol`, `name`, `argCount`, and `execute`.
4.  **Register the Operation**: Add an instance of your class to the `OperationsRegistry` in `lib/src/calculator/domain/operations_registry.dart`.

### Example: Square Operation

```dart
class SquareOperation extends Operation {
  @override
  String get symbol => 'x²';
  
  @override
  String get name => 'Square';
  
  @override
  int get argCount => 0; // Unary operation

  @override
  double execute(double accumulator, [double? operand]) {
    return accumulator * accumulator;
  }
}
```

## How it works
The `CalculatorScreen` uses the `OperationsRegistry` to dynamically build its grid of buttons. When you register a new class, the `Registry` notifies the UI (via a `ChangeNotifier` or similar pattern), and the button is added automatically.
