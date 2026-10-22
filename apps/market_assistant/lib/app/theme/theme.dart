import 'package:flutter/material.dart';

import './colors.dart';
import './fonts.dart';
import './borders.dart';
import './radius.dart';
import './spacing.dart';
import './elements.dart';
import './shadows.dart';

import 'package:ui/theme/theme.dart';

final lightColors = lightUiColors();
final darkColors = darkUiColors();

final lightUiTheme = UiTheme(
  scheme: UiScheme.light,
  colors: lightColors,
  inverseColors: darkColors,
  fonts: fonts,
  borders: borders,
  radius: radius,
  spacing: spacing,
  elements: elements,
  shadows: shadows,
);
final darkUiTheme = lightUiTheme.copyWith(
  scheme: UiScheme.dark,
  colors: darkColors,
  inverseColors: lightColors,
);

final lightThemeData = ThemeData.light().copyWith(extensions: [lightUiTheme]);
final darkThemeData = ThemeData.dark().copyWith(extensions: [darkUiTheme]);
