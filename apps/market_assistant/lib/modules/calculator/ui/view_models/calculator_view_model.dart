import 'package:flutter/widgets.dart';

import '../../domain/measurement.dart';
import '../../domain/product.dart';

import '../states/calculator_state.dart';

final class CalculatorViewModel {
  final ValueNotifier<CalculatorState> _state;

  ValueNotifier<CalculatorState> get state => _state;

  CalculatorViewModel()
    : _state = ValueNotifier<CalculatorState>(
        CalculatorState(
          category: null,
          baseMeasurement: null,
          products: [],
          bestProduct: null,
        ),
      );

  void addProduct(
    MeasurementCategory category,
    Measurement baseMeasurement,
    Product product,
  ) {
    if (_state.value.products.isEmpty) {
      _state.value = CalculatorState(
        category: category,
        baseMeasurement: baseMeasurement,
        products: [product],
        bestProduct: null,
      );
      return;
    }
    final products = List<Product>.from(_state.value.products)..add(product);
    final bestProduct = _getBestProduct(products);
    _state.value = CalculatorState(
      category: _state.value.category,
      baseMeasurement: _state.value.baseMeasurement,
      products: products,
      bestProduct: bestProduct,
    );
  }

  Product _getBestProduct(List<Product> products) {
    Product? best;
    for (var product in products) {
      best ??= product;
      if (product.calculatePricePerAmount() < best.calculatePricePerAmount()) {
        best = product;
      }
    }
    return best!;
  }

  void removeProduct(int index) {
    if (_state.value.products.isEmpty) {
      return;
    }
    final products = List<Product>.from(_state.value.products)..removeAt(index);
    final bestProduct = products.length > 1 ? _getBestProduct(products) : null;
    _state.value = CalculatorState(
      category: products.isEmpty ? null : _state.value.category,
      baseMeasurement: products.isEmpty ? null : _state.value.baseMeasurement,
      products: products,
      bestProduct: bestProduct,
    );
  }

  void removeAllProducts() {
    _state.value = CalculatorState(
      category: null,
      baseMeasurement: null,
      products: [],
      bestProduct: null,
    );
  }
}
