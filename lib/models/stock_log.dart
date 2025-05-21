// 📄 lib/models/stock_log.dart
import 'package:hive/hive.dart';

part 'stock_log.g.dart';

@HiveType(typeId: 1)
class StockLog {
  @HiveField(0)
  final String type; // '입고' or '출고'

  @HiveField(1)
  final int amount;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final DateTime timestamp;

  StockLog({
    required this.type,
    required this.amount,
    required this.note,
    required this.timestamp,
  });
}