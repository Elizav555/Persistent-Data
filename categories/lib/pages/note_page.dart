import 'package:flutter/material.dart';

import '../model/note.dart';

class NotePageArguments {
  final Note note;

  NotePageArguments(this.note);
}

class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  State<StatefulWidget> createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  late Note _note;

  @override
  void didChangeDependencies() {
    setState(() {
      _note = widget.note;
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
