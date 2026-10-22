import 'package:flutter/material.dart';

import '../theme/theme.dart';

final class UiLabel extends StatelessWidget {
  final UiPriority priority;
  final bool inverse;
  final bool accent;

  final UiFontStyle style;

  final bool disabled;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? letterSpacing;

  final String text;

  const UiLabel({
    super.key,

    this.priority = UiPriority.neutral,
    this.inverse = false,
    this.accent = false,

    this.style = UiFontStyle.body,

    this.disabled = false,

    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,

    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final colors = inverse
        ? theme.getInverseColors(priority)
        : theme.getColors(priority);

    final fonts = theme.getFonts(style);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: TextStyle(
        fontFamily: fonts.family,
        fontSize: fonts.size,
        height: fonts.height / fonts.size,
        fontWeight: fonts.weight,
        fontStyle: fonts.style,
        letterSpacing: letterSpacing ?? fonts.letterSpacing,
        color: accent
            ? (disabled ? colors.accentDisabled : colors.accent)
            : disabled
            ? colors.foregroundDisabled
            : colors.foreground,
      ),
    );
  }
}
