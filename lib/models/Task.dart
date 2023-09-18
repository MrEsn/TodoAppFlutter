import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  String date;
  @HiveField(5)
  String time;
  @HiveField(6)
  String level;
  @HiveField(7)
  String category;
  @HiveField(8)
  bool more;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.level,
      required this.category,
      required this.more});
}
