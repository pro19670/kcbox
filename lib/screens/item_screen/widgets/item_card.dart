// 📄 lib/item_screen/widgets/item_card.dart
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final VoidCallback? onDelete;

  const ItemCard({
    super.key,
    required this.name,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
