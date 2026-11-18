import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_provider.dart';

class ScopeBuilder<T, V> extends StatefulWidget {
  final ScopeSelectorType<T, V> selector;
  final ScopeBuilderType<V> builder;
  final Widget? child;

  const ScopeBuilder({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  @override
  State<ScopeBuilder<T, V>> createState() => _ScopeBuilderState<T, V>();
}

class _ScopeBuilderState<T, V> extends State<ScopeBuilder<T, V>> {
  ValueNotifier<T>? _notifier;
  late V _selectedValue;

  void _listener() {
    final updatedValue = widget.selector(_notifier!.value);
    if (updatedValue != _selectedValue) {
      setState(() => _selectedValue = updatedValue);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = ScopeProvider.read<T>(context);
    if (notifier == _notifier) {
      return;
    }
    if (_notifier != null) {
      _notifier!.removeListener(_listener);
    }
    _notifier = notifier;
    _selectedValue = widget.selector(_notifier!.value);
    _notifier!.addListener(_listener);
  }

  @override
  void dispose() {
    _notifier?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _selectedValue, widget.child);
  }
}
