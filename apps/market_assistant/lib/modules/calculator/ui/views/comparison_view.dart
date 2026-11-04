import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

enum ComparisonViewState { initial, adding, calculable }

abstract interface class ComparisonViewModel {
  ComparisonViewState get state;
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
            top: false,
            child: Column(
              children: [
                UiHeader(
                  priority: UiPriority.primary,
                  title: 'Calculadora',
                  leadingIcon: Icons.currency_exchange,
                  hasOffset: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
