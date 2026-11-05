import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/product.dart';
import '../../domain/measurement.dart';

import '../widgets/success_card.dart';

enum ComparisonViewState { initial, adding, calculable }

abstract interface class ComparisonViewModel {
  ComparisonViewState get state;
  Product? get bestProduct;
  Measurement? get baseMeasurement;
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(
                      theme.getSpacing(UiSpacing.lg),
                    ),
                    child: Column(
                      spacing: theme.getSpacing(UiSpacing.lg),
                      children: [
                        if (_viewModel.state == ComparisonViewState.initial)
                          _buildInitialState(context)
                        else
                          _buildCalculableState(context),

                        SizedBox(
                          width: double.infinity,
                          child: UiButton(
                            priority: UiPriority.primary,
                            vertical: UiSpacing.md,
                            radius: UiRadius.xl,
                            onPressed: _viewModel.handleAddProduct,
                            child: UiLabel(
                              text: 'Agregar producto',
                              priority: UiPriority.primary,
                              style: UiFontStyle.caption,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildInitialState(BuildContext context) {
    final theme = context.uiTheme;

    return Flexible(
      child: Column(
        children: [
          Spacer(),
          Center(
            child: UiButton(
              onPressed: _viewModel.handleAddProduct,
              priority: UiPriority.primary,
              vertical: UiSpacing.xl,
              horizontal: UiSpacing.xl,
              radius: UiRadius.full,
              child: UiIcon(
                icon: Icons.add_shopping_cart,
                size: UiElement.xl4,
                priority: UiPriority.primary,
              ),
            ),
          ),
          SizedBox(height: theme.getSpacing(UiSpacing.md)),
          Column(
            spacing: theme.getSpacing(UiSpacing.xs),
            children: [
              UiLabel(text: 'Agrega productos', style: UiFontStyle.caption),
              UiLabel(
                text:
                    'Agrega productos a la calculadora para comparar precios.',
                style: UiFontStyle.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildCalculableState(BuildContext context) {
    final theme = context.uiTheme;

    return Flexible(
      child: Column(
        spacing: theme.getSpacing(UiSpacing.md),
        children: [
          SuccessCard(
            onAddPressed: _viewModel.handleAddProduct,
            product: _viewModel.bestProduct,
            baseMeasurement: _viewModel.baseMeasurement,
          ),
        ],
      ),
    );
  }
}
