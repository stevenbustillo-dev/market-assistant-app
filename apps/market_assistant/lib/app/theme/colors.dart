import 'package:flutter/widgets.dart';
import 'package:ui/theme/theme.dart';

const Map<UiScheme, Map<UiPriority, Map<int, Color>>> _tokens = {
  UiScheme.light: {
    UiPriority.neutral: {
      100: Color(0xFFf9f8fb),
      200: Color(0xFFefeef1),
      300: Color(0xFFdfdee2),
      400: Color(0xFFcfced2),
      500: Color(0xFFbfbec1),
      600: Color(0xFF858488),
      700: Color(0xFF6b6a6d),
      800: Color(0xFF4d4c4f),
    },
    UiPriority.primary: {
      100: Color(0xFFf9f8fb),
      200: Color(0xFFf0edf7),
      300: Color(0xFFe2dcf1),
      400: Color(0xFFdac5ff),
      500: Color(0xFFceb0ff),
      600: Color(0xFF8d7dac),
      700: Color(0xFF795baa),
      800: Color(0xFF57407b),
    },
    UiPriority.secondary: {
      100: Color(0xFFf5f9f8),
      200: Color(0xFFe4f1ee),
      300: Color(0xFFcae4de),
      400: Color(0xFF88decd),
      500: Color(0xFF4cd3bc),
      600: Color(0xFF4d9084),
      700: Color(0xFF007b68),
      800: Color(0xFF00584a),
    },
    UiPriority.danger: {
      100: Color(0xFFfbf8f5),
      200: Color(0xFFf6ede5),
      300: Color(0xFFefdbcd),
      400: Color(0xFFfcc496),
      500: Color(0xFFfaae6e),
      600: Color(0xFFa77c59),
      700: Color(0xFF9f5804),
      800: Color(0xFF733e03),
    },
  },
  UiScheme.dark: {
    UiPriority.neutral: {
      100: Color(0xFFe4e3e7),
      200: Color(0xFFb9b8bc),
      300: Color(0xFF8b8a8d),
      400: Color(0xFF79787b),
      500: Color(0xFF706f72),
      600: Color(0xFF666568),
      700: Color(0xFF3a3a3c),
      800: Color(0xFF2b2a2d),
    },
    UiPriority.primary: {
      100: Color(0xFFeadfff),
      200: Color(0xFFcaa9ff),
      300: Color(0xFF9085a6),
      400: Color(0xFF8967bf),
      500: Color(0xFF7f5fb2),
      600: Color(0xFF6d6085),
      700: Color(0xFF3e364d),
      800: Color(0xFF2d2739),
    },
    UiPriority.secondary: {
      100: Color(0xFFc0ede3),
      200: Color(0xFF2bceb7),
      300: Color(0xFF679389),
      400: Color(0xFF008a75),
      500: Color(0xFF00806c),
      600: Color(0xFF396f65),
      700: Color(0xFF1e3f39),
      800: Color(0xFF152e2a),
    },
    UiPriority.danger: {
      100: Color(0xFFfedec5),
      200: Color(0xFFf9a65f),
      300: Color(0xFFa2846d),
      400: Color(0xFFb26405),
      500: Color(0xFFa65c02),
      600: Color(0xFF815f43),
      700: Color(0xFF4a3524),
      800: Color(0xFF37271a),
    },
  },
};

Map<UiPriority, UiColors> lightUiColors() {
  final Map<UiPriority, UiColors> colors = {};
  for (final priority in UiPriority.values) {
    colors[priority] = UiColors(
      background: _tokens[UiScheme.light]![priority]![200]!,

      surface: _tokens[UiScheme.light]![priority]![100]!,

      subtle: _tokens[UiScheme.light]![priority]![400]!,
      subtlePressed: _tokens[UiScheme.light]![priority]![500]!,
      subtleDisabled: _tokens[UiScheme.light]![priority]![300]!,

      accent: _tokens[UiScheme.light]![priority]![700]!,
      accentDisabled: _tokens[UiScheme.light]![priority]![600]!,

      foreground: _tokens[UiScheme.light]![priority]![800]!,
      foregroundDisabled: _tokens[UiScheme.light]![priority]![600]!,

      shadow: _tokens[UiScheme.light]![priority]![700]!.withAlpha(64),
    );
  }
  return colors;
}

Map<UiPriority, UiColors> darkUiColors() {
  final Map<UiPriority, UiColors> colors = {};
  for (final priority in UiPriority.values) {
    colors[priority] = UiColors(
      background: _tokens[UiScheme.dark]![priority]![800]!,

      surface: _tokens[UiScheme.dark]![priority]![700]!,

      subtle: _tokens[UiScheme.dark]![priority]![400]!,
      subtlePressed: _tokens[UiScheme.dark]![priority]![500]!,
      subtleDisabled: _tokens[UiScheme.dark]![priority]![600]!,

      accent: _tokens[UiScheme.dark]![priority]![200]!,
      accentDisabled: _tokens[UiScheme.dark]![priority]![300]!,

      foreground: _tokens[UiScheme.dark]![priority]![100]!,
      foregroundDisabled: _tokens[UiScheme.dark]![priority]![300]!,

      shadow: _tokens[UiScheme.dark]![priority]![200]!.withAlpha(64),
    );
  }
  return colors;
}
