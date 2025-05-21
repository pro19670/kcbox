// 📄 lib/item_screen/item_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/0_background_with_title.dart';
import 'widgets/item_card.dart';
import '../../models/item_model.dart';
import 'item_detail_screen.dart';
import '../../providers/item_provider.dart';
import '../../models/stock_log.dart';

class ItemScreen extends StatelessWidget {
  final String subLocationName;
  final String? imagePath;

  const ItemScreen({
    super.key,
    required this.subLocationName,
    this.imagePath,
  });

  void _addOrEditItemDialog(BuildContext context, {Item? existing}) async {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final brandController = TextEditingController(text: existing?.brand ?? '');
    final colorController = TextEditingController(text: existing?.color ?? '');
    final quantityController = TextEditingController();
    final noteController = TextEditingController();
    String selectedType = '입고';

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? '물품 추가 + 입출고' : '물품 수정 + 입출고'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: '품명')),
              TextField(controller: brandController, decoration: const InputDecoration(labelText: '브랜드')),
              TextField(controller: colorController, decoration: const InputDecoration(labelText: '색상')),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedType,
                onChanged: (value) => selectedType = value!,
                items: const [
                  DropdownMenuItem(value: '입고', child: Text('입고')),
                  DropdownMenuItem(value: '출고', child: Text('출고')),
                ],
                decoration: const InputDecoration(labelText: '유형'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: '수량'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: '비고'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final brand = brandController.text.trim();
              final color = colorController.text.trim();
              final note = noteController.text.trim();
              final amount = int.tryParse(quantityController.text.trim()) ?? 0;

              if (name.isNotEmpty && amount > 0) {
                final log = StockLog(
                  type: selectedType,
                  amount: amount,
                  note: note,
                  timestamp: DateTime.now(),
                );

                final updated = (existing ?? Item(
                  name: name,
                  brand: brand,
                  color: color,
                  quantity: 0,
                  locationPath: subLocationName,
                  logs: [],
                  createdAt: DateTime.now(),
                )).addLog(log);

                final provider = context.read<ItemProvider>();
                if (existing == null) {
                  await provider.addItem(updated);
                } else {
                  await provider.updateItem(updated);
                }
              }
              Navigator.pop(context);
            },
            child: const Text('저장'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<ItemProvider>().byLocation(subLocationName);
    final totalQty = items.fold(0, (sum, item) => sum + item.quantity); // ✅ 총 수량 계산

    return BackgroundWithTitle(
      title: '$subLocationName (총 $totalQty개)', // ✅ AppBar에 총 재고 수량 표시
      image: imagePath,
      onAddPressed: () => _addOrEditItemDialog(context),
      child: items.isEmpty
          ? const Center(child: Text('물품이 없습니다.'))
          : SingleChildScrollView( // ✅ Wrap을 위한 스크롤뷰 추가
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: items.map((item) {
                  return ItemCard(
                    name: '${item.name} (${item.quantity}개)',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ItemDetailScreen(
                            item: item,
                            onItemUpdated: (updated) => context.read<ItemProvider>().updateItem(updated),
                          ),
                        ),
                      );
                    },
                    onEdit: () => _addOrEditItemDialog(context, existing: item), // ✅ 수정 기능 연결
                    onDelete: () => context.read<ItemProvider>().deleteItem(item.id),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
