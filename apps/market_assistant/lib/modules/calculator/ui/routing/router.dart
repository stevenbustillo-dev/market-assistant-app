import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:native_scope/native_scope.dart';

import '../view_models/calculator_view_model.dart';

import './comparison_route.dart';
import './product_form_route.dart';

final _calculatorNavigatorKey = GlobalKey<NavigatorState>();

final calculatorRouter = ShellRoute(
  navigatorKey: _calculatorNavigatorKey,
  builder: (context, state, child) =>
      ScopeInjector(injectable: CalculatorViewModel(), child: child),
  routes: [
    GoRoute(
      path: '/calculator/comparison',
      builder: (context, state) => const ComparisonRoute(),
    ),
    GoRoute(
      path: '/calculator/product',
      builder: (context, state) => const ProductFormRoute(),
    ),
  ],
);
