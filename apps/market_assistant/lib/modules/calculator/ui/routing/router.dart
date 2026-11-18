import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/repositories/measurement_repository.dart';

import '../states/calculator_state.dart';

import '../view_models/comparison_view_model.dart';
import '../views/comparison_view.dart';

import '../view_models/product_form_view_model.dart';
import '../views/product_form_view.dart';

final _calculatorNavigatorKey = GlobalKey<NavigatorState>();

final calculatorRouter = ShellRoute(
  navigatorKey: _calculatorNavigatorKey,
  builder: (context, state, child) => child,
  routes: [
    GoRoute(
      path: '/calculator/comparison',
      builder: (context, state) => ComparisonView(
        viewModel: DefaultComparisonViewModel(
          context: context,
          state: CalculatorState(),
        ),
      ),
    ),
    GoRoute(
      path: '/calculator/product',
      builder: (context, state) => ProductFormView(
        viewModel: DefaultProductFormViewModel(
          context: context,
          measurementRepository: LocalMeasurementRepository(),
        ),
      ),
    ),
  ],
);
