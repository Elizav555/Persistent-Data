import 'package:categories/model/note.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';
import 'model/category.dart';

const String categories = 'categories';
const String notes = 'notes';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Category>(categories);
  await Hive.openBox<Note>(notes);
  runApp(const MyApp());
}
