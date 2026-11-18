import 'package:flutter/widgets.dart';
import './scope_types.dart';
import './scope_listener.dart';
import './scope_builder.dart';

class ScopeConsumer<T, V> extends StatelessWidget {
  final ScopeSelectorType<T, V> selector;
  final ScopeListenerType<V> listener;
  final ScopeBuilderType<V> builder;
  final Widget? child;

  const ScopeConsumer({
    super.key,
    required this.selector,
    required this.listener,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScopeListener<T, V>(
      selector: selector,
      listener: listener,
      child: ScopeBuilder<T, V>(
        selector: selector,
        builder: builder,
        child: child,
      ),
    );
  }
}
