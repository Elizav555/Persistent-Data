import 'package:categories/pages/categories_list_page.dart';
import 'package:categories/pages/note_page.dart';
import 'package:categories/pages/notes_list_page.dart';
import 'package:categories/utils/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.categoriesList,
      routes: {
        Routes.categoriesList: (context) =>
            const CategoriesList(title: 'Categories List'),
        Routes.notesList: (context) => const NotesList(title: 'Notes List'),
        Routes.note: (context) => const NotePage(),
      },
    );
  }
}
