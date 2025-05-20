import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../../widgets/0_background_with_title.dart';
import '../structure_screen/structure_screen.dart';
import 'widgets/location_card.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<Location> locations = [];

  void _addLocationDialog() async {
    final controller = TextEditingController();
    String? selectedImage; // ❗ 배경선택 제거됨. 기본은 null → 무시됨

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('공간 추가'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '예: 우리집, 사무실'),
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
                  locations.add(Location(
                    name: name,
                    imagePath: selectedImage, // 🔧 이미지 선택 없이 null로 저장해도 구조상 문제 없음
                  ));
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

  @override
  Widget build(BuildContext context) {
    return BackgroundWithTitle(
      title: '내 공간 선택하기',
      image: 'assets/images/home_bg.jpg', // ✅ StartScreen은 고정된 배경 이미지 사용
      onAddPressed: _addLocationDialog,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: locations.isEmpty
            ? const Center(child: Text('등록된 공간이 없습니다.'))
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: locations.map((location) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: LocationCard(
                      location: location,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StructureScreen(location: location),
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
