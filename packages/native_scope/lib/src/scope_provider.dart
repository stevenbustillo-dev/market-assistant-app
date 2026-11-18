import 'package:flutter/widgets.dart';

class ScopeProvider<T> extends InheritedNotifier<ValueNotifier<T>> {
  const ScopeProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<T> read<T>(BuildContext context) {
    final provider = context.getInheritedWidgetOfExactType<ScopeProvider<T>>();
    assert(provider != null, 'No ScopeProvider<$T> found in context.');
    return provider!.notifier!;
  }

  static ValueNotifier<T> watch<T>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ScopeProvider<T>>();
    assert(provider != null, 'No ScopeProvider<$T> found in context.');
    return provider!.notifier!;
  }
}
