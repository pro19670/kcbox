// 📄 lib/widgets/0_common_header.dart
import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAddPressed;
  final VoidCallback? onSelectBackgroundPressed;

  const CommonHeader({
    super.key,
    required this.title,
    this.onAddPressed,
    this.onSelectBackgroundPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 분리
      children: [
        if (Navigator.canPop(context)) // ✅ 뒤로가기 조건부 표시
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        const SizedBox(width: 4),
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onAddPressed != null)
                  WidgetSpan(
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 30, color: Colors.white),
                      padding: const EdgeInsets.only(left: 4),
                      constraints: const BoxConstraints(),
                      onPressed: onAddPressed,
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
              ],
            ),
          ),
        ),
        if (onSelectBackgroundPressed != null)
          TextButton(
            onPressed: onSelectBackgroundPressed,
            child: const Text(
              '배경선택',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
