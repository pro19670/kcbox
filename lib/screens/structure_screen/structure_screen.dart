// 📄 lib/structure_screen/structure_screen.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // ✅ 이미지 선택용
import 'dart:io';
import '../../models/location.dart';
import '../../widgets/0_background_with_title.dart';
import '../room_screen/room_screen.dart';
import 'widgets/room_card.dart';

class StructureScreen extends StatefulWidget {
  final Location location;

  const StructureScreen({super.key, required this.location});

  @override
  State<StructureScreen> createState() => _StructureScreenState();
}

class _StructureScreenState extends State<StructureScreen> {
  final List<String> rooms = [];
  late Location currentLocation; // ✅ 복사본으로 상태 관리

  @override
  void initState() {
    super.initState();
    currentLocation = widget.location; // ✅ 초기값 설정
  }

  void _addRoomDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('방 추가'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) setState(() => rooms.add(name));
              Navigator.pop(context);
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

  // ✅ 이미지 선택 기능 + 복사본 교체
  void _showBackgroundSelectDialog() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        currentLocation = currentLocation.copyWith(imagePath: path); // ✅ Location은 불변 → 복사본 생성
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithTitle(
      title: '${currentLocation.name} 구조도',
      image: currentLocation.imagePath,
      onAddPressed: _addRoomDialog,
      onSelectBackgroundPressed: _showBackgroundSelectDialog, // ✅ 연결됨
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: rooms.isEmpty
            ? const Center(child: Text('방을 추가하세요.'))
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: rooms.map((room) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: RoomCard(
                      name: room,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RoomScreen(
                              roomName: room,
                              imagePath: currentLocation.imagePath, // ✅ 전달 유지
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
