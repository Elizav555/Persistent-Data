import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
enum Category {
  @HiveField(0)
  music,
  @HiveField(1)
  films,
  @HiveField(2)
  games,
  @HiveField(3)
  books,
  @HiveField(4, defaultValue: true)
  common
}
