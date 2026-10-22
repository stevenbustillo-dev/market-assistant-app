import 'package:go_router/go_router.dart';

import './index_route.dart';

import '../../modules/onboarding/ui/routing/router.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [indexRoute, buildOnboardingRouter()],
);
