import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedStorage = '냉장고1';

  final List<Map<String, dynamic>> storageList = [
    {'name': '냉장고1'},
    {'name': '큰방옷장'},
    {'name': '신발장'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KCBox 저장소 관리'),
      ),
      body: Row(
        children: [
          // 좌측 박스 (크기 50% 축소됨)
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: storageList.map((storage) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedStorage = storage['name'];
                    });
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Card(
                      elevation: 3,
                      child: Center(
                        child: Text(
                          storage['name'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // 우측 상세
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📦 $selectedStorage 상세 보기',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const Divider(height: 20),
                  const Text('재고 수량:'),
                  const Text('- 소고기: 2개'),
                  const Text('- 김치: 1통'),
                  const Text('- 계란: 12개'),
                  const SizedBox(height: 20),
                  const Text('🔍 필터 기능 (예: 유통기한 순, 재고 많은 순 등)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}