import 'package:material_ui/material_ui.dart';

import '../theme/theme.dart';

import './label.dart';

final class UiFieldLayout extends StatelessWidget {
  final UiPriority priority;
  final String? title;
  final Widget child;
  final String? hint;
  final bool hasError;

  const UiFieldLayout({
    super.key,
    this.priority = UiPriority.neutral,
    this.title,
    required this.child,
    this.hint,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    return Column(
      spacing: theme.getSpacing(UiSpacing.xs),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.getSpacing(UiSpacing.xs),
            ),
            child: UiLabel(
              text: title!,
              priority: priority,
              style: UiFontStyle.caption,
            ),
          ),

        child,

        if (hint != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.getSpacing(UiSpacing.xs),
            ),
            child: UiLabel(
              text: hint!,
              priority: hasError ? UiPriority.danger : priority,
              style: UiFontStyle.hint,
            ),
          ),
      ],
    );
  }
}
