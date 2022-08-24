import 'package:categories/model/category.dart';
import 'package:hive/hive.dart';

import '../model/note.dart';

class NotesRep {
  final Map<Category, Box<Note>> categoriesBoxes = {};

  NotesRep() {
    _initBoxes();
    _initNotes();
  }

  Future<void> _initBoxes() async {
    for (var cat in Category.values) {
      categoriesBoxes[cat] = await Hive.openBox<Note>(cat.name);
    }
  }

  Future<void> _initNotes() async {
    for (var boxMap in categoriesBoxes.entries) {
      final notesList = List.generate(
          5,
          (index) => Note(index, boxMap.key, boxMap.key.name + index.toString(),
              'Text$index'));
      final Map<int, Note> notesMap = {};
      for (var note in notesList) {
        notesMap[note.id] = note;
      }
      boxMap.value.putAll(notesMap);
    }
  }
}
