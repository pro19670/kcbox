// 📄 lib/models/location.dart
import 'package:uuid/uuid.dart';

class Location {
  final String id;
  final String name;
  final String? imagePath;

  Location({
    String? id,
    required this.name,
    this.imagePath,
  }) : id = id ?? const Uuid().v4();

  // 🔧 복사본 생성: 기존 Location을 기반으로 특정 필드만 수정
  Location copyWith({
    String? id,
    String? name,
    String? imagePath,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  // JSON 변환 (선택적으로 SharedPreferences 등에서 사용 가능)
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imagePath': imagePath,
      };

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}
