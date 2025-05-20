// 📄 lib/item_screen/item_screen.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // ✅ 이미지 선택용
import '../../widgets/0_background_with_title.dart';
import 'widgets/item_card.dart';

class ItemScreen extends StatefulWidget {
  final String subLocationName;
  final String? imagePath; // ✅ 추가

  const ItemScreen({
    super.key,
    required this.subLocationName,
    this.imagePath,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final List<String> items = [];
  late String? _imagePath; // ✅ 상태 변수

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
  }

  void _addItemDialog() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('물품 추가'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '예: 쌀 10kg, 반팔티 3개'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  items.add(name);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _selectBackgroundImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _imagePath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithTitle(
      title: '${widget.subLocationName} 물품',
      image: _imagePath, // ✅ 적용
      onAddPressed: _addItemDialog,
      onSelectBackgroundPressed: _selectBackgroundImage, // ✅ 배경선택 연결
      child: items.isEmpty
          ? const Center(child: Text('물품이 없습니다.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ItemCard(
                  name: items[index],
                  onDelete: () => _deleteItem(index),
                );
              },
            ),
    );
  }
}
