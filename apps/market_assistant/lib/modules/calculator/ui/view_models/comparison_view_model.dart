import 'package:flutter/widgets.dart';

import '../../domain/product.dart';
import '../../domain/measurement.dart';

import '../states/calculator_state.dart';
import '../views/comparison_view.dart';

import '../../infrastructure/data/measurements.dart';

final class DefaultComparisonViewModel implements ComparisonViewModel {
  ComparisonViewState get state => ComparisonViewState.adding;
  Product? get bestProduct => Product(
    description: 'Producto 1',
    price: 200,
    unitPerPackage: 1,
    amountPerUnit: 400,
    measurement: measurementCategories[0].measurements[2],
  );
  Measurement? get baseMeasurement => measurementCategories[0].measurements[1];

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
