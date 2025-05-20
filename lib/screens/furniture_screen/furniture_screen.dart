// 📄 lib/furniture_screen/furniture_screen.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // ✅ 이미지 선택용
import '../../widgets/0_background_with_title.dart';
import '../item_screen/item_screen.dart';
import 'widgets/sublocation_card.dart';

class FurnitureScreen extends StatefulWidget {
  final String furnitureName;
  final String? imagePath; // ✅ 전달받은 배경 이미지

  const FurnitureScreen({
    super.key,
    required this.furnitureName,
    required this.imagePath, // ✅ 유지
  });

  @override
  State<FurnitureScreen> createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  final List<String> subLocations = [];
  late String? _imagePath; // ✅ 로컬 상태 이미지 경로

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
  }

  void _addSubLocationDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('위치 추가'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) setState(() => subLocations.add(name));
              Navigator.pop(context);
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
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
      title: '${widget.furnitureName}의 내부 위치',
      image: _imagePath, // ✅ 이미지 상태 반영
      onAddPressed: _addSubLocationDialog,
      onSelectBackgroundPressed: _selectBackgroundImage, // ✅ 배경선택 연결
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: subLocations.isEmpty
            ? const Center(child: Text('위치를 추가하세요.'))
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: subLocations.map((slot) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: SubLocationCard(
                      name: slot,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemScreen(
                              subLocationName: slot,
                              imagePath: _imagePath, // ✅ 하위 전달
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
