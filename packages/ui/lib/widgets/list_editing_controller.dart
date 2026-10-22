import 'package:flutter/foundation.dart';

class ListEditingController<T> extends ValueNotifier<List<T>> {
  ListEditingController([List<T>? initialItems])
    : super(initialItems != null ? List.from(initialItems) : []);

  @override
  set value(List<T> newValue) {
    super.value = List.unmodifiable(List.from(newValue));
  }

  void _updateList(void Function(List<T> list) action) {
    final currentList = List<T>.from(value);
    action(currentList);
    value = currentList;
  }

  int get length => value.length;
  bool get isEmpty => value.isEmpty;
  bool get isNotEmpty => value.isNotEmpty;

  T operator [](int index) => value[index];

  void add(T element) {
    _updateList((list) => list.add(element));
  }

  void addAll(Iterable<T> elements) {
    _updateList((list) => list.addAll(elements));
  }

  void insert(int index, T element) {
    _updateList((list) => list.insert(index, element));
  }

  void insertAll(int index, Iterable<T> elements) {
    _updateList((list) => list.insertAll(index, elements));
  }

  bool remove(T element) {
    bool removed = false;
    _updateList((list) {
      removed = list.remove(element);
    });
    return removed;
  }

  T removeAt(int index) {
    late T item;
    _updateList((list) {
      item = list.removeAt(index);
    });
    return item;
  }

  void removeWhere(bool Function(T element) test) {
    _updateList((list) => list.removeWhere(test));
  }

  void update(int index, T element) {
    if (index >= 0 && index < value.length) {
      _updateList((list) => list[index] = element);
    }
  }

  void reorder(int oldIndex, int newIndex) {
    _updateList((list) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  void clear() {
    if (value.isNotEmpty) {
      value = [];
    }
  }
}
