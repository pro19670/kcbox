// 📄 lib/widgets/0_background_with_title.dart
import 'package:flutter/material.dart';
import 'dart:io'; // ✅ File image 사용
import '0_common_header.dart'; // ✅ 분리된 헤더 위젯 사용

class BackgroundWithTitle extends StatelessWidget {
  final String title;
  final String? image;
  final VoidCallback? onAddPressed;
  final VoidCallback? onSelectBackgroundPressed;
  final Widget child;

  const BackgroundWithTitle({
    super.key,
    required this.title,
    this.image,
    this.onAddPressed,
    this.onSelectBackgroundPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// ✅ 배경 이미지 분기 처리 (null → 연녹색, assets, file)
        if (image == null)
          Positioned.fill(child: Container(color: Colors.green.shade100))
        else if (image!.startsWith('assets/'))
          Positioned.fill(
            child: Image.asset(image!, fit: BoxFit.cover),
          )
        else
          Positioned.fill(
            child: Image.file(File(image!), fit: BoxFit.cover),
          ),

        /// ✅ 반투명 오버레이
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.4)),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CommonHeader( // ✅ 공통 헤더 위젯 사용
                  title: title,
                  onAddPressed: onAddPressed,
                  onSelectBackgroundPressed: onSelectBackgroundPressed,
                ),
              ),
            ),
          ),
          body: child,
        ),
      ],
    );
  }
}
