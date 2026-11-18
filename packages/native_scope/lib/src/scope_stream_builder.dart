import 'dart:async';

import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_stream_provider.dart';

class ScopeStreamBuilder<T, V> extends StatefulWidget {
  final V initialValue;
  final ScopeSelectorType<T, V> selector;
  final ScopeBuilderType<V> builder;
  final Widget? child;

  const ScopeStreamBuilder({
    super.key,
    required this.initialValue,
    required this.selector,
    required this.builder,
    this.child,
  });

  @override
  State<ScopeStreamBuilder<T, V>> createState() =>
      _ScopeStreamBuilderState<T, V>();
}

class _ScopeStreamBuilderState<T, V> extends State<ScopeStreamBuilder<T, V>> {
  StreamController<T>? _controller;
  StreamSubscription<T>? _subscription;
  late V _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _listener(T data) {
    final updatedValue = widget.selector(data);
    if (updatedValue != _selectedValue) {
      setState(() => _selectedValue = updatedValue);
    }
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
    return widget.builder(context, _selectedValue, widget.child);
  }
}
