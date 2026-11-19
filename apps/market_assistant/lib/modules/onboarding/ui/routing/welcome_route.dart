import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';

import '../view_models/welcome_view_model.dart';
import '../views/welcome_view.dart';

final class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final welcomeViewModel = WelcomeViewModel(context: context);

    return ScopeInjector(injectable: welcomeViewModel, child: WelcomeView());
  }
}
