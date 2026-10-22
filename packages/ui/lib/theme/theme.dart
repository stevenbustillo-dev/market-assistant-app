import 'package:flutter/material.dart';

enum UiScheme { light, dark }

enum UiPriority { neutral, primary, secondary, danger }

final class UiColors {
  final Color background;

  final Color surface;

  final Color subtle;
  final Color subtlePressed;
  final Color subtleDisabled;

  final Color accent;
  final Color accentDisabled;

  final Color foreground;
  final Color foregroundDisabled;

  final Color shadow;

  const UiColors({
    required this.background,

    required this.surface,

    required this.subtle,
    required this.subtlePressed,
    required this.subtleDisabled,

    required this.accent,
    required this.accentDisabled,

    required this.foreground,
    required this.foregroundDisabled,

    required this.shadow,
  });

  UiColors lerp(covariant UiColors? other, double t) {
    if (other == null || identical(this, other)) {
      return this;
    }

    return UiColors(
      background: Color.lerp(background, other.background, t)!,

      surface: Color.lerp(surface, other.surface, t)!,

      subtle: Color.lerp(subtle, other.subtle, t)!,
      subtlePressed: Color.lerp(subtlePressed, other.subtlePressed, t)!,
      subtleDisabled: Color.lerp(subtleDisabled, other.subtleDisabled, t)!,

      accent: Color.lerp(accent, other.accent, t)!,
      accentDisabled: Color.lerp(accentDisabled, other.accentDisabled, t)!,

      foreground: Color.lerp(foreground, other.foreground, t)!,
      foregroundDisabled: Color.lerp(
        foregroundDisabled,
        other.foregroundDisabled,
        t,
      )!,

      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

enum UiFontStyle {
  title,
  subtitle,
  body,
  caption,
  label,
  input,
  inputAlt,
  hint,
}

final class UiFonts {
  final String family;
  final double size;
  final double height;
  final FontWeight? weight;
  final FontStyle? style;
  final double? letterSpacing;

  const UiFonts({
    required this.family,
    required this.size,
    required this.height,
    this.weight,
    this.style,
    this.letterSpacing,
  });
}

enum UiBorder { none, hairline, edge, thick, heavy }

enum UiRadius { none, xs, sm, md, lg, xl, full }

enum UiSpacing { none, xs, sm, md, lg, xl }

enum UiElement { xs, sm, md, lg, xl, xl2 }

enum UiShadow { none, xs, sm, md, lg, xl }

final class UiBoxShadow {
  final double offsetX;
  final double offsetY;
  final double blurRadius;
  final double spreadRadius;

  const UiBoxShadow({
    required this.offsetX,
    required this.offsetY,
    required this.blurRadius,
    required this.spreadRadius,
  });
}

final class UiTheme extends ThemeExtension<UiTheme> {
  final UiScheme scheme;
  final Map<UiPriority, UiColors> colors;
  final Map<UiPriority, UiColors> inverseColors;

  final Map<UiFontStyle, UiFonts> fonts;

  final Map<UiBorder, double> borders;
  final Map<UiRadius, double> radius;

  final Map<UiSpacing, double> spacing;
  final Map<UiElement, double> elements;

  final Map<UiShadow, List<UiBoxShadow>> shadows;

  const UiTheme({
    required this.scheme,
    required this.colors,
    required this.inverseColors,

    required this.fonts,

    required this.borders,
    required this.radius,

    required this.spacing,
    required this.elements,

    required this.shadows,
  });

  @override
  ThemeExtension<UiTheme> copyWith({
    UiScheme? scheme,
    Map<UiPriority, UiColors>? colors,
    Map<UiPriority, UiColors>? inverseColors,

    Map<UiFontStyle, UiFonts>? fonts,

    Map<UiBorder, double>? borders,
    Map<UiRadius, double>? radius,

    Map<UiSpacing, double>? spacing,
    Map<UiElement, double>? elements,

    Map<UiShadow, List<UiBoxShadow>>? shadows,
  }) {
    return UiTheme(
      scheme: scheme ?? this.scheme,
      colors: colors ?? this.colors,
      inverseColors: inverseColors ?? this.inverseColors,

      fonts: fonts ?? this.fonts,

      borders: borders ?? this.borders,
      radius: radius ?? this.radius,

      spacing: spacing ?? this.spacing,
      elements: elements ?? this.elements,

      shadows: shadows ?? this.shadows,
    );
  }

  @override
  ThemeExtension<UiTheme> lerp(
    covariant ThemeExtension<UiTheme>? other,
    double t,
  ) {
    if (other is! UiTheme) {
      return this;
    }

    return UiTheme(
      scheme: t < 0.5 ? scheme : other.scheme,
      colors: colors.map((key, value) {
        final otherValue = other.colors[key];
        return MapEntry(key, value.lerp(otherValue, t));
      }),
      inverseColors: inverseColors.map((key, value) {
        final otherValue = other.inverseColors[key];
        return MapEntry(key, value.lerp(otherValue, t));
      }),

      fonts: t < 0.5 ? fonts : other.fonts,

      borders: t < 0.5 ? borders : other.borders,
      radius: t < 0.5 ? radius : other.radius,

      spacing: t < 0.5 ? spacing : other.spacing,
      elements: t < 0.5 ? elements : other.elements,

      shadows: t < 0.5 ? shadows : other.shadows,
    );
  }

  UiColors getColors(UiPriority priority) =>
      colors[priority] ?? colors[UiPriority.neutral]!;

  UiColors getInverseColors(UiPriority priority) =>
      inverseColors[priority] ?? inverseColors[UiPriority.neutral]!;

  UiFonts getFonts(UiFontStyle style) =>
      fonts[style] ?? fonts[UiFontStyle.body]!;

  double getBorder(UiBorder border) => borders[border] ?? 0.0;

  double getRadius(UiRadius radius) => this.radius[radius] ?? 0.0;

  double getSpacing(UiSpacing space) => spacing[space] ?? 0.0;

  double getElement(UiElement element) => elements[element] ?? 0.0;

  List<UiBoxShadow> getShadow(UiShadow shadow) => shadows[shadow] ?? [];
}

extension UiThemeExtension on BuildContext {
  UiTheme get uiTheme => Theme.of(this).extension<UiTheme>()!;
}
