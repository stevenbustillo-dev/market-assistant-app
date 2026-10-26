import 'package:go_router/go_router.dart';

import '../view_models/onboarding_view_model.dart';
import '../views/welcome_view.dart';

StatefulShellRoute buildOnboardingRouter() => StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return navigationShell;
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/onboarding/welcome',
          builder: (context, state) =>
              WelcomeView(viewModel: OnboardingViewModel(context: context)),
        ),
      ],
    ),
  ],
);
