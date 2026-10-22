import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

import './button.dart';
import './icon.dart';

enum UiFieldType { text, password, number, decimal }

enum UiFieldCase { upper, lower }

final class UiField<T> extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;

  final UiFieldType type;

  final UiPriority priority;
  final bool hasError;

  final UiRadius radius;

  final String? placeholder;
  final bool readOnly;
  final bool disabled;
  final void Function()? onTap;

  /// Optional input mask. Use `#` for digits, `A` for letters, `*` for
  /// alphanumeric characters and any other character as a literal.
  /// Example: `##/##/####`.
  final String? mask;
  final UiFieldCase? textCase;

  final Widget Function(bool focused)? prefix;
  final Widget Function(bool focused)? suffix;

  const UiField({
    super.key,

    this.focusNode,
    this.controller,

    this.type = UiFieldType.text,

    this.priority = UiPriority.neutral,
    this.hasError = false,

    this.radius = UiRadius.sm,

    this.placeholder,
    this.readOnly = false,
    this.disabled = false,
    this.onTap,

    this.mask,
    this.textCase,

    this.prefix,
    this.suffix,
  });

  @override
  State<UiField<T>> createState() => _UiFieldState<T>();
}

final class _UiFieldState<T> extends State<UiField<T>> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  bool _showPassword = false;
  bool _hasText = false;
  bool _focused = false;

  FocusNode get _currentFocusNode => widget.focusNode ?? _focusNode;

  TextEditingController get _currentController =>
      widget.controller ?? _controller;

  TextInputType? get _keyboardType => switch (widget.type) {
    UiFieldType.number => const TextInputType.numberWithOptions(
      signed: false,
      decimal: false,
    ),
    UiFieldType.decimal => const TextInputType.numberWithOptions(
      signed: false,
      decimal: true,
    ),
    _ => null,
  };

  List<TextInputFormatter>? get _inputFormatters {
    final mask = widget.mask;
    if (mask != null && mask.isNotEmpty) {
      return [_MaskTextInputFormatter(mask)];
    }
    return switch (widget.type) {
      UiFieldType.number => [FilteringTextInputFormatter.digitsOnly],
      UiFieldType.decimal => const [_DecimalTextInputFormatter()],
      _ => null,
    };
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _currentFocusNode.addListener(_handleFocusNode);
    _controller = TextEditingController();
    _currentController.addListener(_listenCurrentController);
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  String _applyCase(String text) {
    if (widget.textCase == null) return text;
    return switch (widget.textCase!) {
      UiFieldCase.upper => text.toUpperCase(),
      UiFieldCase.lower => text.toLowerCase(),
    };
  }

  void _listenCurrentController() {
    setState(() {
      _hasText = _currentController.text.isNotEmpty;
    });
  }

  void _handleFocusNode() {
    setState(() {
      _focused = _currentFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _currentFocusNode.removeListener(_handleFocusNode);
    _focusNode.dispose();
    _currentController.removeListener(_listenCurrentController);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    final neutralColors = theme.getColors(UiPriority.neutral);
    final neutralInverseColors = theme.getInverseColors(UiPriority.neutral);

    final priorityInverseColors = theme.getInverseColors(widget.priority);

    final dangerColors = theme.getColors(UiPriority.danger);
    final dangerInverseColors = theme.getInverseColors(UiPriority.danger);

    final fontStyle = theme.getFonts(UiFontStyle.input);

    final borderRadius = BorderRadius.circular(theme.getRadius(widget.radius));
    final borderWidth = theme.getBorder(UiBorder.hairline);
    final activeBorderWidth = theme.getBorder(UiBorder.edge);

    final prefixSuffixConstraints = BoxConstraints(minHeight: 0, minWidth: 0);

    final hasSuffix = widget.suffix != null;
    final hasPasswordToggle = widget.type == UiFieldType.password && _hasText;

    return TextField(
      focusNode: _currentFocusNode,
      controller: _currentController,
      onChanged: (value) => _currentController.text = _applyCase(value),
      readOnly: widget.readOnly,
      showCursor: !widget.readOnly,
      onTap: widget.onTap,
      enabled: !widget.disabled,
      keyboardType: _keyboardType,
      inputFormatters: _inputFormatters,
      style: TextStyle(
        fontFamily: fontStyle.family,
        fontSize: fontStyle.size,
        height: fontStyle.height / fontStyle.size,
        fontWeight: fontStyle.weight,
        fontStyle: fontStyle.style,
        letterSpacing: widget.type == UiFieldType.password && !_showPassword
            ? 4
            : 0.5,
        color: widget.disabled
            ? neutralColors.foregroundDisabled
            : neutralColors.foreground,
      ),
      obscureText: widget.type == UiFieldType.password && !_showPassword,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        visualDensity: VisualDensity.standard,
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          fontFamily: fontStyle.family,
          fontSize: fontStyle.size,
          height: fontStyle.height / fontStyle.size,
          fontWeight: fontStyle.weight,
          fontStyle: fontStyle.style,
          letterSpacing: 0.5,
          color: widget.disabled
              ? neutralColors.foregroundDisabled.withAlpha(192)
              : neutralColors.foregroundDisabled,
        ),
        filled: true,
        fillColor: widget.disabled
            ? neutralColors.background
            : neutralColors.surface,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconConstraints: prefixSuffixConstraints,
        prefixIcon: widget.prefix == null
            ? null
            : Padding(
                padding: EdgeInsetsGeometry.only(
                  left: theme.getSpacing(UiSpacing.sm),
                ),
                child: widget.prefix!(_focused),
              ),
        suffixIconConstraints: prefixSuffixConstraints,
        suffixIcon: hasPasswordToggle || hasSuffix
            ? Padding(
                padding: EdgeInsetsGeometry.only(
                  right: theme.getSpacing(UiSpacing.sm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: theme.getSpacing(UiSpacing.sm),
                  children: [
                    if (hasPasswordToggle)
                      UiButton(
                        onPressed: _toggleShowPassword,
                        vertical: UiSpacing.sm,
                        horizontal: UiSpacing.xs,
                        priority: widget.hasError
                            ? UiPriority.danger
                            : widget.priority,
                        disabled: widget.disabled,
                        alpha: true,
                        radius: UiRadius.full,
                        child: UiIcon(
                          priority: _focused
                              ? widget.priority
                              : UiPriority.neutral,
                          disabled: widget.disabled,
                          size: UiElement.sm,
                          icon: _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          accent: true,
                        ),
                      ),
                    if (hasSuffix) widget.suffix!(_focused),
                  ],
                ),
              )
            : null,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: theme.getSpacing(UiSpacing.sm),
          horizontal: theme.getSpacing(UiSpacing.sm),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError
                ? dangerColors.subtleDisabled
                : neutralColors.subtleDisabled,
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError
                ? dangerInverseColors.subtlePressed
                : neutralInverseColors.subtlePressed,
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError
                ? dangerInverseColors.subtlePressed
                : priorityInverseColors.subtlePressed,
            width: activeBorderWidth,
          ),
        ),
      ),
    );
  }
}

final class _MaskTextInputFormatter extends TextInputFormatter {
  _MaskTextInputFormatter(this.mask);

  final String mask;

  bool _isPlaceholder(String maskChar) {
    return maskChar == '#' || maskChar == 'A' || maskChar == '*';
  }

  bool _matches(String char, String maskChar) {
    switch (maskChar) {
      case '#':
        return RegExp(r'^[0-9]$').hasMatch(char);
      case 'A':
        return RegExp(r'^[A-Za-zÀ-ÿñÑ]$', unicode: true).hasMatch(char);
      case '*':
        return RegExp(r'^[A-Za-z0-9À-ÿñÑ]$', unicode: true).hasMatch(char);
      default:
        return false;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final input = newValue.text;
    final buffer = StringBuffer();
    var inputIndex = 0;

    for (var i = 0; i < mask.length && inputIndex < input.length; i++) {
      final maskChar = mask[i];
      if (_isPlaceholder(maskChar)) {
        while (inputIndex < input.length) {
          final char = input[inputIndex];
          inputIndex++;
          if (_matches(char, maskChar)) {
            buffer.write(char);
            break;
          }
        }
      } else {
        if (inputIndex < input.length && input[inputIndex] == maskChar) {
          inputIndex++;
        }
        buffer.write(maskChar);
      }
    }

    final result = buffer.toString();
    final offset = result.length.clamp(0, result.length);
    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

final class _DecimalTextInputFormatter extends TextInputFormatter {
  const _DecimalTextInputFormatter();

  static const String _decimalSeparator = '.';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }
    final escaped = RegExp.escape(_decimalSeparator);
    final pattern = RegExp('^[0-9]*$escaped?[0-9]*\$');
    if (pattern.hasMatch(text)) {
      return newValue;
    }
    return oldValue;
  }
}
