import 'package:categories/model/category.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  Category category;
  @HiveField(2)
  String title;
  @HiveField(3)
  String text;

  Note(this.id, this.category, this.title, this.text);
}
