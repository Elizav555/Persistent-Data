import 'package:flutter/material.dart';

import '../model/note.dart';

class NotePageArguments {
  final Note note;

  NotePageArguments(this.note);
}

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  late Note _note;

  @override
  void didChangeDependencies() {
    setState(() {
      _note = (ModalRoute.of(context)!.settings.arguments as NotePageArguments)
          .note;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_note.title),
      ),
      body: Center(
        child: Text(_note.text),
      ),
    );
  }
}
