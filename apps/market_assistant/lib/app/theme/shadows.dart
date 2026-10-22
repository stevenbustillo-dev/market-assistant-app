import 'package:ui/theme/theme.dart';

const Map<UiShadow, List<UiBoxShadow>> shadows = {
  UiShadow.none: [],
  UiShadow.xs: [
    UiBoxShadow(offsetX: 0, offsetY: 1, blurRadius: 2, spreadRadius: 0),
  ],
  UiShadow.sm: [
    UiBoxShadow(offsetX: 0, offsetY: 1, blurRadius: 3, spreadRadius: 0),
    UiBoxShadow(offsetX: 0, offsetY: 1, blurRadius: 2, spreadRadius: -1),
  ],
  UiShadow.md: [
    UiBoxShadow(offsetX: 0, offsetY: 4, blurRadius: 6, spreadRadius: -1),
    UiBoxShadow(offsetX: 0, offsetY: 2, blurRadius: 4, spreadRadius: -2),
  ],
  UiShadow.lg: [
    UiBoxShadow(offsetX: 0, offsetY: 10, blurRadius: 15, spreadRadius: -3),
    UiBoxShadow(offsetX: 0, offsetY: 4, blurRadius: 6, spreadRadius: -4),
  ],
  UiShadow.xl: [
    UiBoxShadow(offsetX: 0, offsetY: 20, blurRadius: 25, spreadRadius: -5),
    UiBoxShadow(offsetX: 0, offsetY: 8, blurRadius: 10, spreadRadius: -6),
  ],
};
