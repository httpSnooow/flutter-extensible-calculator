# Research: Dynamic Operation Discovery in Flutter

## Decision: Command Pattern with Centralized Registry

We will implement each mathematical operation as a class that inherits from a common `Operation` interface. A centralized `OperationsRegistry` will be used to hold all available operations. The UI will build its button grid by iterating over this registry.

## Details

### Operation Interface
- `String get symbol`: The character shown on the button (e.g., '+', 'sqrt').
- `String get name`: Internal identifier or accessibility label.
- `int get argCount`: 0 or 1 (as per user request: "at most 1 parameter").
- `double execute(double accumulator, [double? operand])`: The mathematical logic.

### Registry Implementation
A static class `OperationsRegistry` will contain a `List<Operation>`. At application startup, we will register the basic operations (Addition, Subtraction, etc.).

### UI Decoupling
The `CalculatorScreen` will use a `ListView` or `GridView` to generate buttons based on the items in `OperationsRegistry`. This ensures that adding a new class to the registry automatically updates the UI.

## Rationale
- **Decoupling**: The UI only knows about the `Operation` interface, not concrete classes.
- **Flutter Compatibility**: Avoids `dart:mirrors` which is not available in Flutter.
- **Simplicity**: Easier to understand and debug than code generation for a project of this scale.

## Alternatives Considered
- **Code Generation (build_runner)**: Rejected as overkill for a simple calculator, though more automated for massive systems.
- **Hardcoded Map**: Rejected because it requires modifying the UI/Engine when adding new features.
- **Reflection**: Not supported in Flutter production builds.
