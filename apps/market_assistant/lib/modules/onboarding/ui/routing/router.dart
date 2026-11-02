import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../view_models/welcome_view_model.dart';
import '../views/welcome_view.dart';

final _onboardingNavigatorKey = GlobalKey<NavigatorState>();

final onboardingRouter = ShellRoute(
  navigatorKey: _onboardingNavigatorKey,
  builder: (context, state, child) => child,
  routes: [
    GoRoute(
      path: '/onboarding/welcome',
      builder: (context, state) =>
          WelcomeView(viewModel: DefaultWelcomeViewModel(context: context)),
    ),
  ],
);
