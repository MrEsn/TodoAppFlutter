import 'package:hive/hive.dart';

part 'Category.g.dart';

@HiveType(typeId: 1)
class CategoryNader {
  @HiveField(1)
  String title;
  @HiveField(2)
  String note;
  @HiveField(3)
  int id;
  @HiveField(4)
  bool level;

  CategoryNader({
    required this.title,
    required this.note,
    required this.id,
    required this.level,
  });
}
