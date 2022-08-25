import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../main.dart';
import '../model/category.dart';
import '../model/default_categories.dart';
import '../model/note.dart';
import '../utils/routes.dart';
import 'notes_list_page.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final _inputController = TextEditingController();
  late Box<Category> _categoriesBox;

  @override
  void initState() {
    _categoriesBox = Hive.box<Category>(categories);
    _initBox();
    super.initState();
  }

  void _initBox() {
    for (var cat in DefaultCategories.values) {
      final notesList = List.generate(
          5,
          (index) =>
              Note('Name of ${cat.name} $index', 'Text of ${cat.name} $index'));
      _categoriesBox.put(cat.index, Category(cat.index, cat.name, notesList));
    }
  }

  Future<void> _addCategory(String name) async {
    final key = _categoriesBox.length;
    await _categoriesBox.put(key, Category(key, name, []));
  }

  Future<void> _deleteCategory(int key) async {
    await _categoriesBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder<Box<Category>>(
        valueListenable: _categoriesBox.listenable(),
        builder: (context, Box<Category> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("Category list is empty"),
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                final cat = box.getAt(index);
                if (cat == null) {
                  return Container();
                }
                return ListTile(
                  key: UniqueKey(),
                  title: Text(cat.name),
                  trailing: IconButton(
                    onPressed: () async {
                      await _deleteCategory(cat.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () => Navigator.of(context).pushNamed(Routes.notesList,
                      arguments: NotesListArguments(cat.id)),
                );
              },
              itemCount: box.values.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Widget cancelButton = TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          );
          Widget continueButton = TextButton(
              child: const Text("Add"),
              onPressed: () {
                _addCategory(_inputController.text)
                    .then((value) => Navigator.pop(context, 'Add'));
              });
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add New Category'),
              content: TextField(
                controller: _inputController,
                decoration: const InputDecoration(label: Text('Category Name')),
              ),
              actions: <Widget>[
                cancelButton,
                continueButton,
              ],
            ),
          );
        },
        tooltip: 'Add category',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
