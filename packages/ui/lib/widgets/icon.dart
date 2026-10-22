import 'package:flutter/material.dart';

import '../theme/theme.dart';

final class UiIcon extends StatelessWidget {
  final UiPriority priority;
  final bool inverse;
  final bool accent;

  final UiElement size;

  final bool disabled;

  final IconData icon;

  const UiIcon({
    super.key,

    this.priority = UiPriority.neutral,
    this.inverse = false,
    this.accent = false,

    this.size = UiElement.sm,

    this.disabled = false,

    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final colors = inverse
        ? theme.getInverseColors(priority)
        : theme.getColors(priority);
    final elementSize = theme.getElement(size);

    return Icon(
      icon,
      size: elementSize,
      color: accent
          ? (disabled ? colors.accentDisabled : colors.accent)
          : disabled
          ? colors.foregroundDisabled
          : colors.foreground,
    );
  }
}
