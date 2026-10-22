import 'package:flutter/material.dart';

import '../theme/theme.dart';

import './list_editing_controller.dart';
import './field.dart';
import './button.dart';
import './label.dart';
import './icon.dart';

final class UiSelect<T> extends StatefulWidget {
  final FocusNode? focusNode;

  final ListEditingController<T>? controller;
  final List<T>? list;
  final String Function(T element)? elementToText;
  final Widget Function(
    T element,
    bool selected,
    void Function() handleSelectElement,
  )?
  elementBuilder;
  final bool multiple;

  final UiPriority priority;
  final bool hasError;

  final UiRadius radius;

  final String? placeholder;
  final bool disabled;

  final Widget Function(bool focused)? prefix;
  final Widget Function(bool focused)? suffix;

  const UiSelect({
    super.key,

    this.focusNode,

    this.controller,
    this.list,
    this.elementToText,
    this.elementBuilder,
    this.multiple = false,

    this.priority = UiPriority.neutral,
    this.hasError = false,

    this.radius = UiRadius.sm,

    this.placeholder,
    this.disabled = false,

    this.prefix,
    this.suffix,
  });

  @override
  State<UiSelect<T>> createState() => _UiSelectState<T>();
}

final class _UiSelectState<T> extends State<UiSelect<T>> {
  late TextEditingController _textController;
  late ListEditingController<T> _controller;

  ListEditingController<T> get _currentController =>
      widget.controller ?? _controller;

  final List<T> _selectedElements;

  _UiSelectState() : _selectedElements = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _controller = ListEditingController<T>();
    _currentController.addListener(_listenCurrentController);
    _listenCurrentController();
  }

  String _elementToText(T element) =>
      widget.elementToText?.call(element) ?? element.toString();

  void _listenCurrentController() {
    _textController.text = _currentController.value
        .map(_elementToText)
        .join(', ');
  }

  void _handleSelectElement(
    BuildContext context,
    T element,
    StateSetter setDialogState,
  ) {
    setDialogState(() {
      if (!widget.multiple) {
        _selectedElements.clear();
      }
      if (_selectedElements.contains(element)) {
        _selectedElements.remove(element);
      } else {
        _selectedElements.add(element);
      }
    });
  }

  Widget _elementBuilder(
    BuildContext context,
    T element,
    bool selected,
    StateSetter setDialogState,
  ) {
    if (widget.elementBuilder != null) {
      return widget.elementBuilder!(
        element,
        selected,
        () => _handleSelectElement(context, element, setDialogState),
      );
    }

    final theme = context.uiTheme;

    return SizedBox(
      width: double.infinity,
      child: UiButton(
        priority: selected ? UiPriority.secondary : UiPriority.neutral,
        alpha: true,
        onPressed: () => _handleSelectElement(context, element, setDialogState),
        child: Row(
          spacing: theme.getSpacing(UiSpacing.sm),
          children: [
            Expanded(
              child: UiLabel(
                text: _elementToText(element),
                style: UiFontStyle.input,
                priority: selected ? UiPriority.secondary : UiPriority.neutral,
                accent: selected,
              ),
            ),
            UiIcon(
              priority: selected ? UiPriority.secondary : UiPriority.neutral,
              size: UiElement.sm,
              icon: widget.multiple
                  ? (selected ? Icons.check_box : Icons.check_box_outline_blank)
                  : (selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
              accent: selected,
            ),
          ],
        ),
      ),
    );
  }

  void _handleClearSelection(StateSetter setDialogState) {
    setDialogState(() {
      _selectedElements.clear();
    });
  }

  void _handleConfirmSelection(BuildContext context) {
    setState(() {
      _currentController
        ..clear()
        ..addAll(_selectedElements);
      _selectedElements.clear();
    });
    Navigator.of(context).pop();
  }

  Widget _selectControlBuilder(
    BuildContext context,
    StateSetter setDialogState,
  ) {
    final theme = context.uiTheme;

    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: IntrinsicWidth(
        child: Row(
          spacing: theme.getSpacing(UiSpacing.sm),
          children: [
            Expanded(
              child: UiButton(
                horizontal: UiSpacing.lg,
                disabled: _selectedElements.isEmpty,
                priority: UiPriority.danger,
                onPressed: () => _handleClearSelection(setDialogState),
                alpha: true,
                child: UiIcon(
                  icon: Icons.delete_sweep,
                  size: UiElement.md,
                  priority: UiPriority.danger,
                  accent: true,
                  disabled: _selectedElements.isEmpty,
                ),
              ),
            ),
            Expanded(
              child: UiButton(
                horizontal: UiSpacing.lg,
                priority: UiPriority.secondary,
                onPressed: () => _handleConfirmSelection(context),
                child: UiIcon(
                  icon: widget.multiple ? Icons.checklist : Icons.check,
                  size: UiElement.md,
                  priority: UiPriority.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShowDialog(BuildContext context) {
    _selectedElements.clear();
    _selectedElements.addAll(_currentController.value);

    final theme = context.uiTheme;
    final isEmpty = widget.list == null || widget.list!.isEmpty;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => PopScope(
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.getRadius(UiRadius.lg)),
            ),
            backgroundColor: theme.getColors(UiPriority.neutral).surface,
            child: Padding(
              padding: EdgeInsets.all(theme.getSpacing(UiSpacing.md)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: theme.getSpacing(UiSpacing.sm),
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: UiButton(
                      onPressed: () => Navigator.of(context).pop(),
                      alpha: true,
                      radius: UiRadius.full,
                      child: UiIcon(icon: Icons.close, accent: true),
                    ),
                  ),

                  if (!isEmpty)
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.list!.length,
                        itemBuilder: (context, index) => _elementBuilder(
                          context,
                          widget.list![index],
                          _selectedElements.contains(widget.list![index]),
                          setDialogState,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: theme.getSpacing(UiSpacing.sm)),
                      ),
                    ),

                  _selectControlBuilder(context, setDialogState),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _currentController.removeListener(_listenCurrentController);
    _currentController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;
    final hasSuffix = widget.suffix != null;

    return UiField(
      focusNode: widget.focusNode,
      controller: _textController,
      priority: widget.priority,
      hasError: widget.hasError,
      radius: widget.radius,
      placeholder: widget.placeholder,
      readOnly: true,
      disabled: widget.disabled,
      onTap: () => _handleShowDialog(context),
      prefix: widget.prefix,
      suffix: (focused) => Padding(
        padding: EdgeInsetsGeometry.only(right: theme.getSpacing(UiSpacing.sm)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: theme.getSpacing(UiSpacing.sm),
          children: [
            UiIcon(
              priority: focused ? widget.priority : UiPriority.neutral,
              disabled: widget.disabled,
              size: UiElement.md,
              icon: Icons.keyboard_arrow_down,
              accent: true,
            ),
            if (hasSuffix) widget.suffix!(focused),
          ],
        ),
      ),
    );
  }
}
