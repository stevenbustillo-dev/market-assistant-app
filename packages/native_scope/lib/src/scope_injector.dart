import 'package:flutter/widgets.dart';

class ScopeInjector<T> extends InheritedWidget {
  final T injectable;

  const ScopeInjector({
    super.key,
    required this.injectable,
    required super.child,
  });

  static T read<T>(BuildContext context) {
    final injector = context.getInheritedWidgetOfExactType<ScopeInjector<T>>();
    assert(injector != null, 'No ScopeInjector<$T> found in context.');
    return injector!.injectable;
  }

  static T watch<T>(BuildContext context) {
    final injector = context
        .dependOnInheritedWidgetOfExactType<ScopeInjector<T>>();
    assert(injector != null, 'No ScopeInjector<$T> found in context.');
    return injector!.injectable;
  }

  @override
  bool updateShouldNotify(ScopeInjector<T> oldWidget) =>
      injectable != oldWidget.injectable;
}
