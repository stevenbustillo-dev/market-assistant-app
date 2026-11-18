import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_stream_listener.dart';
import './scope_stream_builder.dart';

class ScopeStreamConsumer<T, V> extends StatelessWidget {
  final V initialValue;
  final ScopeSelectorType<T, V> selector;
  final ScopeListenerType<V> listener;
  final ScopeBuilderType<V> builder;
  final Widget? child;

  const ScopeStreamConsumer({
    super.key,
    required this.initialValue,
    required this.selector,
    required this.listener,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScopeStreamListener<T, V>(
      initialValue: initialValue,
      selector: selector,
      listener: listener,
      child: ScopeStreamBuilder<T, V>(
        initialValue: initialValue,
        selector: selector,
        builder: builder,
        child: child,
      ),
    );
  }
}
