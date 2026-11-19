import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../states/comparison_state.dart';

import './calculator_view_model.dart';

final class ComparisonViewModel {
  final ValueNotifier<ComparisonState> _state;

  ValueNotifier<ComparisonState> get state => _state;

  final BuildContext _context;
  final CalculatorViewModel _calculatorViewModel;

  ComparisonViewModel({
    required this._context,
    required this._calculatorViewModel,
  }) : _state = ValueNotifier<ComparisonState>(
         ComparisonState(
           viewState: ComparisonViewState.initial,
           bestProduct: null,
           baseMeasurement: null,
           products: [],
         ),
       );

  void initState() {
    _calculatorViewModel.state.addListener(_listenCalculatorState);
  }

  void _listenCalculatorState() {
    final ComparisonViewState viewState =
        _calculatorViewModel.state.value.products.isEmpty
        ? ComparisonViewState.initial
        : _calculatorViewModel.state.value.products.length > 1
        ? ComparisonViewState.calculable
        : ComparisonViewState.adding;

    _state.value = ComparisonState(
      viewState: viewState,
      bestProduct: _calculatorViewModel.state.value.bestProduct,
      baseMeasurement: _calculatorViewModel.state.value.baseMeasurement,
      products: _calculatorViewModel.state.value.products,
    );
  }

  void handleAddProduct() {
    _context.push('/calculator/product');
  }

  void handleClearProducts() {
    _calculatorViewModel.removeAllProducts();
  }

  void handleRemoveProduct(int index) {
    _calculatorViewModel.removeProduct(index);
  }

  void dispose() {
    _calculatorViewModel.state.removeListener(_listenCalculatorState);
  }
}
