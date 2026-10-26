import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../views/welcome_view.dart';

final class OnboardingViewModel implements WelcomeViewModel {
  final BuildContext _context;

  const OnboardingViewModel({required this._context});

  @override
  void handleGetStarted() {
    _context.replace('/calculator/comparison');
  }
}
