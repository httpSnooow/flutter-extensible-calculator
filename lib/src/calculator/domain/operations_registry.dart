import 'package:flutter/foundation.dart';
import 'operation.dart';

class OperationsRegistry extends ChangeNotifier {
  final List<Operation> _operations = [];

  List<Operation> get operations => List.unmodifiable(_operations);

  void register(Operation operation) {
    if (!_operations.any((o) => o.symbol == operation.symbol)) {
      _operations.add(operation);
      notifyListeners();
    }
  }

  void unregister(String symbol) {
    _operations.removeWhere((o) => o.symbol == symbol);
    notifyListeners();
  }

  Operation? getBySymbol(String symbol) {
    try {
      return _operations.firstWhere((o) => o.symbol == symbol);
    } catch (_) {
      return null;
    }
  }
}
