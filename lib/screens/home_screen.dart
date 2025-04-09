import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String name;
  String category;
  DateTime addedDate;
  int quantity;
  String storage;

  Item({
    required this.name,
    required this.category,
    required this.addedDate,
    this.quantity = 1,
    required this.storage,
  });
}

class KCBoxHome extends StatefulWidget {
  const KCBoxHome({super.key});

  @override
  State<KCBoxHome> createState() => _KCBoxHomeState();
}

class _KCBoxHomeState extends State<KCBoxHome> {
  List<String> storageNames = [
    '냉장고1', '냉장고2', '냉장고3',
    '침실옷장', '큰방옷장', '작은방옷장', '현관신발장'
  ];

  final List<Item> allItems = [];
  String? selectedStorage;
  String searchKeyword = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  void _showAddItemDialog() {
    nameController.clear();
    categoryController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('아이템 추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: '카테고리'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedStorage != null) {
                setState(() {
                  allItems.add(Item(
                    name: nameController.text,
                    category: categoryController.text,
                    addedDate: DateTime.now(),
                    storage: selectedStorage!,
                  ));
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

Widget _buildStorageCard(String name) {
  IconData iconData;
  if (name.contains('냉장고')) {
    iconData = Icons.kitchen_outlined;
  } else if (name.contains('옷장')) {
    iconData = Icons.checkroom;
  } else if (name.contains('신발장')) {
    iconData = Icons.shopping_bag_outlined;
  } else {
    iconData = Icons.inventory_2;
  }

  return GestureDetector(
    onTap: () => setState(() => selectedStorage = name),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 36, color: Colors.blueGrey),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}

  Widget _buildItemListPanel() {
    final items = allItems.where((item) =>
        item.storage == selectedStorage &&
        (item.name.contains(searchKeyword) || item.category.contains(searchKeyword))).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: '검색어로 필터 (이름 또는 카테고리)',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() => searchKeyword = value),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(item.name),
                subtitle: Text('${item.category} • ${DateFormat('yyyy-MM-dd').format(item.addedDate)}'),
                trailing: Text('${item.quantity}개'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInventorySummary() {
    Map<String, Map<String, int>> summary = {};
    for (var item in allItems) {
      summary.putIfAbsent(item.name, () => {});
      summary[item.name]![item.storage] =
          (summary[item.name]![item.storage] ?? 0) + item.quantity;
    }

    return ListView(
      children: summary.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value.entries.map((e) {
            return ListTile(
              title: Text(e.key),
              trailing: Text('${e.value}개'),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KCBox 아이템 리스트'),
      ),
      body: isWide
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      children: [
                        _buildStorageCard('냉장고1', Icons.kitchen),
                        _buildStorageCard('냉장고2', Icons.kitchen_outlined),
                        _buildStorageCard('냉장고3', Icons.kitchen_rounded),
                        _buildStorageCard('침실옷장', Icons.bedroom_child),
                        _buildStorageCard('큰방옷장', Icons.chair_alt),
                        _buildStorageCard('작은방옷장', Icons.chair),
                        _buildStorageCard('현관신발장', Icons.checkroom),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: Colors.grey.shade300),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedStorage != null
                                  ? '선택: $selectedStorage'
                                  : '보관장소 선택',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: selectedStorage != null ? _showAddItemDialog : null,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: _buildItemListPanel()),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('재고 현황 (이름 + 보관장소별)', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 200, child: _buildInventorySummary()),
                    ],
                  ),
                )
              ],
            )
          : const Center(child: Text('PC에서 이용해 주세요')),
    );
  }
}
