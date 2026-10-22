import 'package:flutter/material.dart';
import 'package:market_assistant/modules/onboarding/ui/views/aux.dart';
import 'package:ui/ui.dart';

abstract interface class WelcomeViewModel {}

final class WelcomeView extends StatelessWidget {
  final WelcomeViewModel _viewModel;
  final TextEditingController _controller;
  final ListEditingController<Aux> _listController;

  WelcomeView({super.key, required this._viewModel})
    : _controller = TextEditingController(),
      _listController = ListEditingController();

  @override
  Widget build(BuildContext context) {
    _viewModel;

    final theme = context.uiTheme;

    return Scaffold(
      backgroundColor: theme.getColors(UiPriority.neutral).background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.getSpacing(UiSpacing.lg)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final priority in UiPriority.values) ...[
                UiLabel(
                  text: priority.name,
                  style: UiFontStyle.title,
                  priority: priority,
                  accent: true,
                ),
                SizedBox(height: theme.getSpacing(UiSpacing.md)),
                UiLabel(
                  text: '${priority.name} disabled',
                  style: UiFontStyle.subtitle,
                  priority: priority,
                  accent: true,
                  disabled: true,
                ),
                SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                _buildComparison(context, priority: priority, inverse: false),
                SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                _buildComparison(context, priority: priority, inverse: true),
                SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                UiSelect<Aux>(
                  controller: _listController,
                  placeholder: "select your aux...",
                  multiple: false,
                  list: [
                    Aux(id: '1', name: 'Item 1'),
                    Aux(id: '2', name: 'Item 2'),
                    Aux(id: '3', name: 'Item 3'),
                    Aux(id: '4', name: 'Item 4'),
                  ],
                  elementToText: (element) => element.name,
                  priority: priority,
                  disabled: false,
                  hasError: false,
                  prefix: (focused) => UiIcon(
                    priority: focused ? priority : UiPriority.neutral,
                    disabled: false,
                    size: UiElement.sm,
                    icon: Icons.lock,
                    accent: true,
                  ),
                  suffix: (focused) => UiIcon(
                    priority: focused ? priority : UiPriority.neutral,
                    disabled: false,
                    size: UiElement.sm,
                    icon: Icons.verified_user,
                    accent: true,
                  ),
                ),
                SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                UiField(
                  controller: _controller,
                  placeholder: "type your password...",
                  type: UiFieldType.text,
                  priority: priority,
                  disabled: false,
                  hasError: false,
                  mask: '###-######-####A',
                  textCase: UiFieldCase.upper,
                  prefix: (focused) => UiIcon(
                    priority: focused ? priority : UiPriority.neutral,
                    disabled: false,
                    size: UiElement.sm,
                    icon: Icons.lock,
                    accent: true,
                  ),
                  suffix: (focused) => UiIcon(
                    priority: focused ? priority : UiPriority.neutral,
                    disabled: false,
                    size: UiElement.sm,
                    icon: Icons.verified_user,
                    accent: true,
                  ),
                ),
                SizedBox(height: theme.getSpacing(UiSpacing.lg)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparison(
    BuildContext context, {
    required UiPriority priority,
    required bool inverse,
  }) {
    final theme = context.uiTheme;

    final rows = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final disabled in const [false, true])
          Padding(
            padding: EdgeInsets.only(bottom: theme.getSpacing(UiSpacing.sm)),
            child: Wrap(
              spacing: theme.getSpacing(UiSpacing.md),
              runSpacing: theme.getSpacing(UiSpacing.sm),
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                UiButton(
                  priority: priority,
                  inverse: inverse,
                  disabled: disabled,
                  onPressed: () {},
                  child: UiLabel(
                    text: disabled ? 'Disabled' : 'Enabled',
                    style: UiFontStyle.caption,
                    priority: priority,
                    inverse: inverse,
                    disabled: disabled,
                  ),
                ),
                UiLabel(
                  text: disabled ? 'Label disabled O0' : 'Label enabled O0',
                  style: disabled ? UiFontStyle.inputAlt : UiFontStyle.caption,
                  priority: priority,
                  inverse: inverse,
                  disabled: disabled,
                ),
              ],
            ),
          ),
      ],
    );

    if (!inverse) {
      return rows;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(theme.getSpacing(UiSpacing.md)),
      decoration: BoxDecoration(
        color: theme.getInverseColors(priority).background,
        borderRadius: BorderRadius.circular(theme.getRadius(UiRadius.md)),
      ),
      child: rows,
    );
  }
}
