import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../views/welcome_view.dart';

final class DefaultWelcomeViewModel implements WelcomeViewModel {
  final BuildContext _context;

  const DefaultWelcomeViewModel({required this._context});

  @override
  void handleGetStarted() {
    _context.push('/calculator/comparison');
  }
}
