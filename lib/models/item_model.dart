// 📄 lib/models/item_model.dart
import 'package:hive/hive.dart';
import 'stock_log.dart';
import 'package:uuid/uuid.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String brand;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final String color;

  @HiveField(5)
  final String locationPath;

  @HiveField(6)
  final List<StockLog> logs;

  @HiveField(7)
  final DateTime createdAt;

  Item({
    String? id,
    required this.name,
    required this.brand,
    required this.quantity,
    required this.color,
    required this.locationPath,
    required this.logs,
    required this.createdAt,
  }) : id = id ?? const Uuid().v4();

  Item addLog(StockLog log) {
    int newQuantity = quantity;
    if (log.type == '입고') {
      newQuantity += log.amount;
    } else if (log.type == '출고') {
      newQuantity -= log.amount;
    }

    return Item(
      id: id,
      name: name,
      brand: brand,
      quantity: newQuantity,
      color: color,
      locationPath: locationPath,
      logs: [...logs, log],
      createdAt: createdAt,
    );
  }
}