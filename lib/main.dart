import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const KCBoxApp());
}

class KCBoxApp extends StatelessWidget {
  const KCBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KCBox',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const KCBoxHome(),
    );
  }
}

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
    '냉장고1', '냉장고2', '냉장고3', '침실옷장', '큰방옷장', '작은방옷장', '현관신발장'
  ];

  String? selectedStorage;
  String searchKeyword = '';
  final List<Item> allItems = [];

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
          Text(name, style: const TextStyle(fontSize: 14))
        ],
      ),
    );
  }

  Widget _buildItemListPanel() {
    final items = allItems.where((item) =>
      item.storage == selectedStorage &&
      (item.name.contains(searchKeyword) || item.category.contains(searchKeyword))
    ).toList();

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
                leading: const Icon(Icons.kitchen_outlined),
                title: Text(item.name),
                subtitle: Text('${item.category} • ${DateFormat('yyyy-MM-dd').format(item.addedDate)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => setState(() {
                        if (item.quantity > 0) item.quantity--;
                      }),
                    ),
                    Text('${item.quantity}개'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => setState(() {
                        item.quantity++;
                      }),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildInventorySummary() {
    Map<String, Map<String, int>> summary = {};
    for (var item in allItems) {
      summary.putIfAbsent(item.name, () => {});
      summary[item.name]![item.storage] = (summary[item.name]![item.storage] ?? 0) + item.quantity;
    }

    return ListView(
      children: summary.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value.entries
              .map((e) => ListTile(
                    title: Text(e.key),
                    trailing: Text('${e.value}개'),
                  ))
              .toList(),
        );
      }).toList(),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              children: storageNames.map(_buildStorageCard).toList(),
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
                      selectedStorage != null ? '선택: $selectedStorage' : '보관장소 선택하세요',
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
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('재고 현황 (이름 + 보관장소별)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 200,
                child: _buildInventorySummary(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.screen_rotation, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('화면을 넓혀주세요.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      appBar: AppBar(
        title: const Text('KCBox 아이템 리스트'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: '영수증으로 등록',
            onPressed: () {},
          )
        ],
      ),
      body: isWide ? _buildWideLayout() : _buildNarrowLayout(),
    );
  }
}
