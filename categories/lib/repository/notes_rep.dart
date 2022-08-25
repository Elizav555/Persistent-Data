// import 'package:categories/model/category.dart';
// import 'package:categories/model/default_categories.dart';
// import 'package:hive/hive.dart';
//
// import '../model/note.dart';
//
// class NotesRepositoryImpl extends NotesRepository {
//   @override
//   Future<void> init() async {
//     categoriesBox = await Hive.openBox<Category>(categories);
//     for (var cat in DefaultCategories.values) {
//       final notesList = List.generate(
//           5,
//           (index) =>
//               Note('Name of ${cat.name} $index', 'Text of ${cat.name} $index'));
//       categoriesBox.put(cat.index, Category(cat.index, cat.name, notesList));
//     }
//   }
//
//   @override
//   Future<void> addCategory(String name) async {
//     final key = categoriesBox.length;
//     await categoriesBox.put(key, Category(key, name, []));
//   }
//
//   @override
//   Future<void> deleteCategory(int key) async {
//     await categoriesBox.delete(key);
//   }
//
//   @override
//   void addNote(int catId, String title, String text) {
//     categoriesBox.get(catId)?.notes.add(Note(title, text));
//   }
//
//   @override
//   void deleteNote(int catId, Note note) {
//     categoriesBox.get(catId)?.notes.remove(note);
//   }
// }
