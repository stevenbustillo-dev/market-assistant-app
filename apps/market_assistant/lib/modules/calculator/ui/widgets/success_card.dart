import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/product.dart';
import '../../domain/measurement.dart';

final class SuccessCard extends StatelessWidget {
  final VoidCallback onAddPressed;
  final Product? product;
  final Measurement? baseMeasurement;

  const SuccessCard({
    super.key,
    required this.onAddPressed,
    this.product,
    this.baseMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final secondaryColors = theme.getColors(UiPriority.secondary);

    final hasInfo = product != null && baseMeasurement != null;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryColors.surface, secondaryColors.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(theme.getRadius(UiRadius.md)),
        border: Border.all(
          color: secondaryColors.subtle,
          width: theme.getBorder(UiBorder.edge),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(theme.getSpacing(UiSpacing.md)),
        child: Row(
          mainAxisAlignment: hasInfo
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (hasInfo)
              _buildProductState(context)
            else
              _buildEmptyState(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          UiButton(
            onPressed: onAddPressed,
            priority: UiPriority.secondary,
            vertical: UiSpacing.sm,
            horizontal: UiSpacing.sm,
            radius: UiRadius.full,
            alpha: true,
            child: UiIcon(
              icon: Icons.bookmark_add,
              priority: UiPriority.secondary,
              size: UiElement.xl,
            ),
          ),
          UiLabel(
            text: 'Agrega un producto más',
            textAlign: TextAlign.center,
            priority: UiPriority.secondary,
            style: UiFontStyle.hint,
          ),
        ],
      ),
    );
  }

  Widget _buildProductState(BuildContext context) {
    final theme = context.uiTheme;

    return Flexible(
      child: Row(
        spacing: theme.getSpacing(UiSpacing.md),
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: theme.getSpacing(UiSpacing.xs),
            ),
            child: UiIcon(
              icon: Icons.military_tech,
              priority: UiPriority.secondary,
              size: UiElement.xl2,
            ),
          ),
          Flexible(
            child: Column(
              spacing: theme.getSpacing(UiSpacing.xs),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiLabel(
                  text: 'Mejor opción',
                  priority: UiPriority.secondary,
                  style: UiFontStyle.hint,
                ),
                UiLabel(
                  text: product!.description,
                  priority: UiPriority.secondary,
                  style: UiFontStyle.caption,
                ),
                Align(
                  alignment: AlignmentGeometry.centerEnd,
                  child: UiLabel(
                    text:
                        '\$${product!.calculatePricePerAmount().toStringAsPrecision(2)} / ${baseMeasurement!.translations[0].singular}',
                    priority: UiPriority.secondary,
                    style: UiFontStyle.body,
                    accent: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
