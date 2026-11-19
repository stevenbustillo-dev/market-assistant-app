import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';
import 'package:ui/ui.dart';

import '../view_models/welcome_view_model.dart';

final class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ScopeInjector.read<WelcomeViewModel>(context);
    final theme = context.uiTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.getColors(UiPriority.primary).background,
              theme.getColors(UiPriority.primary).surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(theme.getSpacing(UiSpacing.lg)),
            child: Column(
              children: [
                Spacer(),
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.getColors(UiPriority.primary).surface,
                      borderRadius: BorderRadius.circular(
                        theme.getRadius(UiRadius.full),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(
                        theme.getSpacing(UiSpacing.xl),
                      ),
                      child: UiIcon(
                        icon: Icons.shopping_cart,
                        size: UiElement.xl4,
                        priority: UiPriority.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: theme.getSpacing(UiSpacing.md)),
                Column(
                  spacing: theme.getSpacing(UiSpacing.xs),
                  children: [
                    UiLabel(
                      text: 'Asistente de Compras',
                      style: UiFontStyle.caption,
                    ),
                    UiLabel(
                      text: 'Obten ayuda para tu estrategia de compras y descubre las mejores ofertas.',
                      style: UiFontStyle.body,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(flex: 2),
                SizedBox(
                  width: double.infinity,
                  child: UiButton(
                    priority: UiPriority.primary,
                    vertical: UiSpacing.md,
                    radius: UiRadius.xl,
                    onPressed: viewModel.handleGetStarted,
                    child: UiLabel(
                      text: 'Empezar',
                      priority: UiPriority.primary,
                      style: UiFontStyle.caption,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
