import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';
import 'package:ui/ui.dart';

import '../../domain/product.dart';

import '../states/comparison_state.dart';
import '../view_models/comparison_view_model.dart';

import '../widgets/success_card.dart';

final class ComparisonView extends StatelessWidget {
  const ComparisonView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ScopeInjector.read<ComparisonViewModel>(context);
    final theme = context.uiTheme;

    return Scaffold(
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
                      ScopeBuilder<ComparisonState, ComparisonViewState>(
                        selector: (state) => state.viewState,
                        builder: (context, value, child) =>
                            value == ComparisonViewState.initial
                            ? _buildInitialState(context)
                            : _buildCalculableState(context),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: UiButton(
                          priority: UiPriority.primary,
                          vertical: UiSpacing.md,
                          radius: UiRadius.xl,
                          onPressed: viewModel.handleAddProduct,
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
    );
  }

  Widget _buildInitialState(BuildContext context) {
    final viewModel = ScopeInjector.read<ComparisonViewModel>(context);
    final theme = context.uiTheme;

    return Flexible(
      child: Column(
        children: [
          Spacer(),
          Center(
            child: UiButton(
              onPressed: viewModel.handleAddProduct,
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
    final viewModel = ScopeInjector.read<ComparisonViewModel>(context);
    final theme = context.uiTheme;

    return Flexible(
      child: Column(
        spacing: theme.getSpacing(UiSpacing.md),
        children: [
          ScopeBuilder<ComparisonState, ComparisonState>(
            selector: (state) => state,
            builder: (context, value, child) => SuccessCard(
              onAddPressed: viewModel.handleAddProduct,
              product: value.bestProduct,
              baseMeasurement: value.baseMeasurement,
            ),
          ),
          Row(
            spacing: theme.getSpacing(UiSpacing.md),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UiLabel(text: 'Comparando', style: UiFontStyle.caption),
              UiButton(
                onPressed: viewModel.handleClearProducts,
                vertical: UiSpacing.xs,
                horizontal: UiSpacing.sm,
                radius: UiRadius.full,
                alpha: true,
                child: Row(
                  spacing: theme.getSpacing(UiSpacing.xs),
                  children: [
                    UiLabel(text: 'Limpiar todos'),
                    UiIcon(icon: Icons.cleaning_services),
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: ScopeBuilder<ComparisonState, List<Product>>(
              selector: (state) => state.products,
              builder: (context, value, child) => ListView.separated(
                itemBuilder: (context, index) =>
                    UiLabel(text: value[index].description),
                separatorBuilder: (context, index) =>
                    SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                itemCount: value.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
