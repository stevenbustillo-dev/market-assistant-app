import 'package:material_ui/material_ui.dart';
import 'package:ui/ui.dart';
import 'package:market_assistant/modules/core/ui/utils/format.dart';

import '../../domain/product.dart';
import '../../domain/measurement.dart';

final class ProductListItem extends StatelessWidget {
  final Product product;
  final Measurement baseMeasurement;
  final void Function() onRemove;

  const ProductListItem({
    super.key,
    required this.product,
    required this.baseMeasurement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final amount = product.amountPerUnit * product.unitPerPackage;
    final translation = product.measurement.translations[0];

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(
              color: theme
                  .getColors(UiPriority.neutral)
                  .subtle
                  .withAlpha((0.25 * 255).toInt()),
              width: theme.getBorder(UiBorder.hairline),
            ),
            borderRadius: BorderRadius.circular(theme.getRadius(UiRadius.md)),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: theme.getSpacing(UiSpacing.sm),
              horizontal: theme.getSpacing(UiSpacing.md),
            ),
            child: Row(
              spacing: theme.getSpacing(UiSpacing.sm),
              children: [
                Expanded(
                  child: Column(
                    spacing: theme.getSpacing(UiSpacing.xs),
                    crossAxisAlignment: .start,
                    children: [
                      UiLabel(
                        text: product.description,
                        style: UiFontStyle.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      UiLabel(
                        text:
                            '\$ ${formatNumber(product.price, 2)} / ${formatNumber(amount, 4)} ${(amount == 1 ? translation.singular : translation.plural)}',
                        style: UiFontStyle.hint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                UiLabel(
                  text:
                      '\$ ${formatNumber(product.calculatePricePerAmount(), 4)} / ${baseMeasurement.translations[0].singular}',
                  style: UiFontStyle.hint,
                  priority: UiPriority.secondary,
                  accent: true,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: UiButton(
            onPressed: onRemove,
            alpha: true,
            radius: UiRadius.md,
            child: UiIcon(icon: Icons.close),
          ),
        ),
      ],
    );
  }
}
