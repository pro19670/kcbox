// 📄 lib/main.dart
import 'package:flutter/material.dart';
import 'screens/start_screen/start_screen.dart'; // ✅ 경로 수정

void main() {
  runApp(const KCBoxApp());
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
      home: const StartScreen(), // 앱 시작 화면
    );
  }
}
