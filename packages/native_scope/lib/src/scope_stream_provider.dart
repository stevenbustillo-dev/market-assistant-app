import 'dart:async';

import 'package:flutter/widgets.dart';

class ScopeStreamProvider<T> extends InheritedWidget {
  final StreamController<T> controller;

  const ScopeStreamProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static StreamController<T> read<T>(BuildContext context) {
    final provider = context
        .getInheritedWidgetOfExactType<ScopeStreamProvider<T>>();
    assert(provider != null, 'No ScopeStreamProvider<$T> found in context.');
    return provider!.controller;
  }

  static StreamController<T> watch<T>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ScopeStreamProvider<T>>();
    assert(provider != null, 'No ScopeStreamProvider<$T> found in context.');
    return provider!.controller;
  }

  @override
  bool updateShouldNotify(ScopeStreamProvider<T> oldWidget) => false;
}
