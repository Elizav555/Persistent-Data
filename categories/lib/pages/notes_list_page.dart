import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../main.dart';
import '../model/category.dart';
import '../model/note.dart';

class NotesListArguments {
  final int categoryId;

  NotesListArguments(this.categoryId);
}

class NotesList extends StatefulWidget {
  const NotesList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => NotesListState();
}

class NotesListState extends State<NotesList> {
  final _inputTitleController = TextEditingController();
  final _inputTextController = TextEditingController();
  late Box<Category> _categoriesBox;

  @override
  void initState() {
    _categoriesBox = Hive.box<Category>(categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NotesListArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder<Box<Category>>(
        valueListenable: _categoriesBox.listenable(),
        builder: (context, Box<Category> box, _) {
          final notesList = box.get(args.categoryId)?.notes;
          if (notesList == null || notesList.isEmpty) {
            return const Center(
              child: Text("Notes list is empty"),
            );
          }
          return ListView.builder(
              itemBuilder: (context, index) {
                final note = notesList.elementAt(index);
                return ListTile(
                  key: UniqueKey(),
                  title: Text(note.title),
                  trailing: IconButton(
                    onPressed: () {
                      _categoriesBox.get(args.categoryId)?.notes.remove(note);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
              itemCount: notesList.length);
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
                _categoriesBox.get(args.categoryId)?.notes.add(Note(
                    _inputTitleController.text, _inputTextController.text));
                Navigator.pop(context, 'Add');
              });
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add New Note'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _inputTitleController,
                    decoration:
                        const InputDecoration(label: Text('Note Title')),
                  ),
                  TextField(
                    controller: _inputTextController,
                    decoration: const InputDecoration(label: Text('Note Text')),
                  )
                ],
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
    _inputTextController.dispose();
    _inputTitleController.dispose();
    super.dispose();
  }
}
