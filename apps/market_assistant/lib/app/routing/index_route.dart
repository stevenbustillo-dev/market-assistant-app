import 'package:go_router/go_router.dart';

final indexRoute = GoRoute(
  path: '/',
  // Redirect to the onboarding welcome page for the first time or to the
  // dashboard page if the user has already completed onboarding.
  redirect: (context, state) => '/onboarding/welcome',
);
