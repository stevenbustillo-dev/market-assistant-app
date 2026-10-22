import 'package:flutter/material.dart';

import '../theme/theme.dart';

final class UiButton extends StatelessWidget {
  final UiPriority priority;
  final bool inverse;
  final bool alpha;

  final UiShadow shadow;

  final UiSpacing vertical;
  final UiSpacing horizontal;

  final UiBorder border;
  final UiRadius radius;

  final bool disabled;

  final VoidCallback onPressed;
  final Widget child;

  const UiButton({
    super.key,

    this.priority = UiPriority.neutral,
    this.inverse = false,
    this.alpha = false,

    this.shadow = UiShadow.xs,

    this.vertical = UiSpacing.sm,
    this.horizontal = UiSpacing.sm,

    this.border = UiBorder.none,
    this.radius = UiRadius.sm,

    this.disabled = false,

    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final colors = theme.getColors(priority);
    final inverseColors = theme.getInverseColors(priority);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.radius[radius]!),
        boxShadow: disabled || alpha
            ? []
            : theme
                  .getShadow(shadow)
                  .map(
                    (uiShadow) => BoxShadow(
                      color: (inverse ? inverseColors : colors).shadow,
                      offset: Offset(uiShadow.offsetX, uiShadow.offsetY),
                      blurRadius: uiShadow.blurRadius,
                      spreadRadius: uiShadow.spreadRadius,
                      blurStyle: BlurStyle.normal,
                    ),
                  )
                  .toList(),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              final disabledColor =
                  (inverse ? inverseColors : colors).subtleDisabled;
              return alpha ? disabledColor.withAlpha(32) : disabledColor;
            }
            if (states.contains(WidgetState.pressed)) {
              final pressedColor =
                  (inverse ? inverseColors : colors).subtlePressed;
              return alpha ? pressedColor.withAlpha(64) : pressedColor;
            }
            final idleColor = (inverse ? inverseColors : colors).subtle;
            return alpha ? idleColor.withAlpha(16) : idleColor;
          }),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              vertical: theme.spacing[vertical]!,
              horizontal: theme.spacing[horizontal]!,
            ),
          ),
          side: WidgetStateProperty.resolveWith((states) {
            if (border == UiBorder.none) {
              return null;
            }
            Color borderColor = (inverse ? colors : inverseColors).subtle;
            if (states.contains(WidgetState.disabled)) {
              borderColor = (inverse ? colors : inverseColors).subtleDisabled;
            }
            if (states.contains(WidgetState.pressed)) {
              borderColor = (inverse ? colors : inverseColors).subtlePressed;
            }
            return BorderSide(
              color: borderColor,
              width: theme.borders[border]!,
            );
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.radius[radius]!),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.standard,
        ),
        onPressed: disabled ? null : onPressed,
        child: child,
      ),
    );
  }
}
