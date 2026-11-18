import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_provider.dart';

class ScopeListener<T, V> extends StatefulWidget {
  final ScopeSelectorType<T, V> selector;
  final ScopeListenerType<V> listener;
  final Widget child;

  const ScopeListener({
    super.key,
    required this.selector,
    required this.listener,
    required this.child,
  });

  @override
  State<ScopeListener<T, V>> createState() => _ScopeListenerState<T, V>();
}

class _ScopeListenerState<T, V> extends State<ScopeListener<T, V>> {
  ValueNotifier<T>? _notifier;
  late V _previousValue;

  void _listener() {
    final currentValue = widget.selector(_notifier!.value);
    if (currentValue == _previousValue) {
      return;
    }
    widget.listener(context, _previousValue, currentValue);
    _previousValue = currentValue;
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
    _previousValue = widget.selector(_notifier!.value);
    _notifier!.addListener(_listener);
  }

  @override
  void dispose() {
    _notifier?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
