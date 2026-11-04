import 'package:flutter/material.dart';

import '../theme/theme.dart';

import './icon.dart';
import './label.dart';
import './button.dart';

final class UiHeader extends StatelessWidget {
  final UiPriority priority;

  final String? title;

  final IconData? leadingIcon;
  final IconData? trailingIcon;

  final VoidCallback? onLeadingIconPressed;
  final VoidCallback? onTrailingIconPressed;

  final bool hasOffset;

  const UiHeader({
    super.key,

    this.priority = UiPriority.neutral,

    this.title,

    this.leadingIcon,
    this.trailingIcon,

    this.onLeadingIconPressed,
    this.onTrailingIconPressed,

    this.hasOffset = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final hasActions =
        (leadingIcon != null && onLeadingIconPressed != null) ||
        (trailingIcon != null && onTrailingIconPressed != null);

    final topOffset = MediaQuery.paddingOf(context).top;

    return Container(
      decoration: BoxDecoration(color: theme.getColors(priority).surface),
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          top:
              theme.getSpacing(hasActions ? UiSpacing.sm : UiSpacing.md) +
              (hasOffset ? topOffset : 0),
          bottom: theme.getSpacing(hasActions ? UiSpacing.sm : UiSpacing.md),
          start: theme.getSpacing(hasActions ? UiSpacing.md : UiSpacing.lg),
          end: theme.getSpacing(hasActions ? UiSpacing.md : UiSpacing.lg),
        ),
        child: Row(
          children: [
            if (leadingIcon != null)
              _buildIcon(leadingIcon!, onLeadingIconPressed),
            Spacer(),
            if (title != null)
              UiLabel(
                text: title!,
                style: UiFontStyle.caption,
                priority: priority,
              ),
            Spacer(),
            if (trailingIcon != null)
              _buildIcon(trailingIcon!, onTrailingIconPressed)
            else if (leadingIcon != null)
              SizedBox(
                width: theme.getElement(
                  onLeadingIconPressed != null ? UiElement.xl : UiElement.md,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback? onPressed) {
    final iconWidget = UiIcon(
      icon: icon,
      size: UiElement.md,
      priority: priority,
    );
    if (onPressed == null) {
      return iconWidget;
    }
    return UiButton(
      onPressed: onPressed,
      priority: priority,
      alpha: true,
      radius: UiRadius.full,
      child: iconWidget,
    );
  }
}
