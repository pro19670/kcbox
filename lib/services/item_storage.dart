// 📄 lib/services/item_storage.dart
import 'package:hive/hive.dart';
import '../models/item_model.dart';

class ItemStorage {
  static const String boxName = 'items';

  /// 아이템 전체 목록 불러오기
  static List<Item> loadItems() {
    final box = Hive.box<Item>(boxName);
    return box.values.toList();
  }

  /// 단일 아이템 저장 또는 수정
  static Future<void> saveItem(Item item) async {
    final box = Hive.box<Item>(boxName);
    await box.put(item.id, item);
  }

  /// 아이템 삭제
  static Future<void> deleteItem(String id) async {
    final box = Hive.box<Item>(boxName);
    await box.delete(id);
  }

  /// 전체 초기화 (테스트용)
  static Future<void> clearAll() async {
    final box = Hive.box<Item>(boxName);
    await box.clear();
  }
}
