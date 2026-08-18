import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemViewModel extends ChangeNotifier {
  final List _items = [];

  List get items => _items; // READ

  // CREATE
  void addItem(String name, String description) {
    if (name.trim().isEmpty || description.trim().isEmpty) return;
    final newItem = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
    );
    _items.add(newItem);
    notifyListeners(); // Refresh UI
  }

  // UPDATE
  void updateItem(String id, String newName) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1 && newName.isNotEmpty) {
      _items[index].name = newName;
      notifyListeners(); // Refresh UI
    }
  }

  // DELETE
  void deleteItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners(); // Refresh UI
  }
}