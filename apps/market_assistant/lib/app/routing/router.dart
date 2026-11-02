import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import './index_route.dart';

import '../../modules/onboarding/ui/routing/router.dart';
import '../../modules/calculator/ui/routing/router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [indexRoute, onboardingRouter, calculatorRouter],
);
