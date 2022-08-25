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
      home: const CategoriesList(title: 'Categories List'),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.categoriesList:
            {
              return MaterialPageRoute(
                builder: (context) {
                  return const CategoriesList(title: 'Categories List');
                },
              );
            }
          case Routes.notesList:
            {
              final args = settings.arguments as NotesListArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return NotesList(
                    category: args.category,
                  );
                },
              );
            }
          case Routes.note:
            {
              final args = settings.arguments as NotePageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return NotePage(
                    note: args.note,
                  );
                },
              );
            }
          default:
            {
              assert(false, 'Need to implement ${settings.name}');
              return null;
            }
        }
      },
    );
  }
}
