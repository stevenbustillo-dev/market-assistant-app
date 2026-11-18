import 'dart:async';

import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_stream_provider.dart';

class ScopeStreamListener<T, V> extends StatefulWidget {
  final V initialValue;
  final ScopeSelectorType<T, V> selector;
  final ScopeListenerType<V> listener;
  final Widget child;

  const ScopeStreamListener({
    super.key,
    required this.initialValue,
    required this.selector,
    required this.listener,
    required this.child,
  });

  @override
  State<ScopeStreamListener<T, V>> createState() =>
      _ScopeStreamListenerState<T, V>();
}

class _ScopeStreamListenerState<T, V> extends State<ScopeStreamListener<T, V>> {
  StreamController<T>? _controller;
  StreamSubscription<T>? _subscription;
  late V _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.initialValue;
  }

  void _listener(T data) {
    final currentValue = widget.selector(data);
    if (currentValue == _previousValue) {
      return;
    }
    widget.listener(context, _previousValue, currentValue);
    _previousValue = currentValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = ScopeStreamProvider.read<T>(context);
    if (controller == _controller) {
      return;
    }
    if (_subscription != null) {
      _subscription!.cancel();
    }
    _controller = controller;
    _subscription = _controller!.stream.listen(_listener);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
