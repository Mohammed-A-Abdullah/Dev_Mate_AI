import 'home_tool_type.dart';

class HomeQuickToolEntity {
  final HomeToolType type;
  final String? title;
  final String? description;

  const HomeQuickToolEntity({
    required this.type,
     this.title,
     this.description,
  });
}
