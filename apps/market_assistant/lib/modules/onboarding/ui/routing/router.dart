import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import './welcome_route.dart';

final _onboardingNavigatorKey = GlobalKey<NavigatorState>();

final onboardingRouter = ShellRoute(
  navigatorKey: _onboardingNavigatorKey,
  builder: (context, state, child) => child,
  routes: [
    GoRoute(
      path: '/onboarding/welcome',
      builder: (context, state) => const WelcomeRoute(),
    ),
  ],
);
