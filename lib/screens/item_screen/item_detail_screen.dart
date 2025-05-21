// 📄 lib/item_screen/item_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/item_model.dart';
import '../../models/stock_log.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;
  final Function(Item updated) onItemUpdated;

  const ItemDetailScreen({
    super.key,
    required this.item,
    required this.onItemUpdated,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  void _handleStockChangeDialog() async {
    String selectedType = '입고';
    final amountController = TextEditingController();
    final noteController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('입출고 등록'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              onChanged: (value) => setState(() => selectedType = value!),
              items: const [
                DropdownMenuItem(value: '입고', child: Text('입고')),
                DropdownMenuItem(value: '출고', child: Text('출고')),
              ],
              decoration: const InputDecoration(labelText: '유형'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '수량'),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: '비고'),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              final amount = int.tryParse(amountController.text.trim()) ?? 0;
              final note = noteController.text.trim();
              if (amount > 0) {
                final log = StockLog(
                  type: selectedType,
                  amount: amount,
                  note: note,
                  timestamp: DateTime.now(),
                );
                setState(() {
                  _item = _item.addLog(log);
                });
                widget.onItemUpdated(_item);
                context.read<ItemProvider>().updateItem(_item);
                Navigator.pop(context);
              }
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_item.brand} / ${_item.color} / ${_item.quantity}개',
                style: const TextStyle(fontSize: 16)),
            Text('보관 위치: ${_item.locationPath}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleStockChangeDialog,
              child: const Text('입출고 등록'),
            ),
            const Divider(height: 30),
            const Text('입출고 기록', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _item.logs.length,
                itemBuilder: (context, index) {
                  final log = _item.logs.reversed.toList()[index];
                  return ListTile(
                    leading: Icon(
                      log.type == '입고' ? Icons.add_box : Icons.indeterminate_check_box,
                      color: log.type == '입고' ? Colors.green : Colors.red,
                    ),
                    title: Text('${log.type} ${log.amount}개'),
                    subtitle: Text('${log.timestamp.toLocal().toString().split(".")[0]} - ${log.note}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
