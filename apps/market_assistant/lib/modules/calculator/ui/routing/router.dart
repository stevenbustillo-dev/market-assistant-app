import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import './calculator_route.dart';
import './comparison_route.dart';
import './product_form_route.dart';

final _calculatorNavigatorKey = GlobalKey<NavigatorState>();

final calculatorRouter = ShellRoute(
  navigatorKey: _calculatorNavigatorKey,
  builder: (context, state, child) => CalculatorRoute(child: child),
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
