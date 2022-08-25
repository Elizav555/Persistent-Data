import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../main.dart';
import '../model/category.dart';
import '../model/note.dart';
import '../utils/routes.dart';
import 'note_page.dart';

class NotesListArguments {
  final Category category;

  NotesListArguments(this.category);
}

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotesListState();
}

class NotesListState extends State<NotesList> {
  final _inputTitleController = TextEditingController();
  final _inputTextController = TextEditingController();
  late Box<Note> _notesBox;
  late Category _category;

  @override
  void initState() {
    _notesBox = Hive.box<Note>(notes);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _category =
          (ModalRoute.of(context)!.settings.arguments as NotesListArguments)
              .category;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
      ),
      body: _category.notes.isEmpty
          ? const Center(
              child: Text("Notes list is empty"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final note = _category.notes.elementAt(index);
                return ListTile(
                  key: UniqueKey(),
                  title: Text(note.title),
                  trailing: IconButton(
                    onPressed: () async {
                      await note.delete();
                      setState(() {
                        _category;
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () => Navigator.of(context).pushNamed(Routes.note,
                      arguments: NotePageArguments(note)),
                );
              },
              itemCount: _category.notes.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Widget cancelButton = TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          );
          Widget continueButton = TextButton(
              child: const Text("Add"),
              onPressed: () {
                final note =
                    Note(_inputTitleController.text, _inputTextController.text);
                _notesBox.add(note);
                _category.notes.add(note);
                _category.save();
                setState(() {
                  _category;
                });
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
        tooltip: 'Add note',
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
