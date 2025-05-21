// 📄 lib/providers/item_provider.dart
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/item_storage.dart';

class ItemProvider extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get allItems => List.unmodifiable(_items);

  Future<void> loadItems() async {
    final loaded = ItemStorage.loadItems();
    _items.clear();
    _items.addAll(loaded);
    notifyListeners();
  }

  Future<void> addItem(Item item) async {
    await ItemStorage.saveItem(item);
    _items.add(item);
    notifyListeners();
  }

  Future<void> updateItem(Item item) async {
    await ItemStorage.saveItem(item);
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      _items[index] = item;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    await ItemStorage.deleteItem(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  List<Item> byLocation(String locationPath) {
    return _items.where((e) => e.locationPath == locationPath).toList();
  }

  int countIn(String locationPath) {
    return _items.where((e) => e.locationPath.startsWith(locationPath)).length;
  }
}
