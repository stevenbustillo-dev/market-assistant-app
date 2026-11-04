import 'package:flutter/widgets.dart';

import '../states/calculator_state.dart';
import '../views/comparison_view.dart';

final class DefaultComparisonViewModel implements ComparisonViewModel {
  ComparisonViewState get state => ComparisonViewState.initial;

  final BuildContext _context;
  final CalculatorState _state;

  const DefaultComparisonViewModel({
    required this._context,
    required this._state,
  });

  @override
  void handleAddProduct() {
    print('handleAddProduct');
  }

  @override
  void handleClearProducts() {
    print('handleClearProducts');
  }

  @override
  void handleRemoveProduct(int index) {
    print('handleRemoveProduct: $index');
  }
}
