// 📄 lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/item_model.dart';
import 'models/stock_log.dart';
import 'screens/start_screen/start_screen.dart';
import 'providers/item_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(StockLogAdapter());
  await Hive.openBox<Item>('items');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider()..loadItems(), // ✅ Provider 등록 및 로드
      child: const KCBoxApp(),
    ),
  );
}

class KCBoxApp extends StatelessWidget {
  const KCBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KCBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey.shade200,
        fontFamily: 'Pretendard',
      ),
      home: const StartScreen(),
    );
  }
}
