import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final class WelcomeViewModel {
  final BuildContext _context;

  const WelcomeViewModel({required this._context});

  void handleGetStarted() {
    _context.push('/calculator/comparison');
  }
}
