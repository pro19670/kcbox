// 📄 lib/screens/item_screen/widgets/item_card.dart
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit; // ✅ 수정 기능 추가

  const ItemCard({
    super.key,
    required this.name,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( // ✅ 정사각형 크기 지정
      width: 100,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: onEdit,
                      tooltip: '수정',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      onPressed: onDelete,
                      tooltip: '삭제',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
