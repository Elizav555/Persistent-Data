import 'package:hive/hive.dart';

import 'note.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<Note> notes;

  Category(this.id, this.name, this.notes);
}
