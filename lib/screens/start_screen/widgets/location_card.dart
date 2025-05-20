// 📄 lib/start_screen/widgets/location_card.dart
import 'package:flutter/material.dart';
import '../../../models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback? onTap;

  const LocationCard({
    super.key,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          location.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
