// 📄 lib/room_screen/room_screen.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; 
import '../../widgets/0_background_with_title.dart';
import '../furniture_screen/furniture_screen.dart';
import 'widgets/furniture_card.dart';

class RoomScreen extends StatefulWidget {
  final String roomName;
  final String? imagePath; // ✅ 추가: 배경 이미지 경로 전달용

  const RoomScreen({
    super.key,
    required this.roomName,
    this.imagePath, // ✅ 추가
  });

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final List<String> furnitureList = [];
  late String? _imagePath; // ✅ 로컬 상태에서 배경을 관리

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath; // ✅ 초기값 설정
  }

  void _addFurnitureDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('가구 추가'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) setState(() => furnitureList.add(name));
              Navigator.pop(context);
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

  void _selectBackgroundImage() async {
    // ✅ 이미지 선택기
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
      title: '${widget.roomName}의 가구',
      image: _imagePath, // ✅ 수정: 상태 기반 이미지 경로
      onAddPressed: _addFurnitureDialog,
      onSelectBackgroundPressed: _selectBackgroundImage, // ✅ 배경선택 기능 연결
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: furnitureList.isEmpty
            ? const Center(child: Text('가구를 추가하세요.'))
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: furnitureList.map((furniture) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: FurnitureCard(
                      name: furniture,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FurnitureScreen(
                              furnitureName: furniture,
                              imagePath: _imagePath, // ✅ 하위로 전달
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
