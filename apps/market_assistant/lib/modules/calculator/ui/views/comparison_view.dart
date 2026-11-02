import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

abstract interface class ComparisonViewModel {
  void handleAddProduct();
  void handleRemoveProduct(int index);
  void handleClearProducts();
}

final class ComparisonView extends StatelessWidget {
  final ComparisonViewModel _viewModel;

  const ComparisonView({super.key, required this._viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.getColors(UiPriority.neutral).background,
                theme.getColors(UiPriority.neutral).surface,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: theme.getSpacing(UiSpacing.md),
                    horizontal: theme.getSpacing(UiSpacing.lg),
                  ),
                  child: Row(
                    children: [
                      UiIcon(icon: Icons.currency_exchange, size: UiElement.md),
                      Spacer(),
                      UiLabel(text: 'Calculadora', style: UiFontStyle.caption),
                      Spacer(),
                      SizedBox(width: theme.getElement(UiElement.md)),
                    ],
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
