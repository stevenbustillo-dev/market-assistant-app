import 'package:flutter/widgets.dart';

typedef ScopeSelectorType<T, V> = V Function(T state);

typedef ScopeListenerType<T> =
    void Function(BuildContext context, T previous, T current);

typedef ScopeBuilderType<T> =
    Widget Function(BuildContext context, T value, Widget? child);
