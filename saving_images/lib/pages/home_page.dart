import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late String imagesPath;
  List<File>? images;
  final _inputController = TextEditingController();

  @override
  void initState() {
    if (!kIsWeb) {
      _init();
    }
    super.initState();
  }

  Future<void> _init() async {
    final appDocDir = Platform.isIOS || Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getDownloadsDirectory();
    if (appDocDir != null) {
      imagesPath = path.join(appDocDir.path, "images");
      final imagesDir = await Directory(imagesPath).create(recursive: true);
      images = await imagesDir.list().map((file) => File(file.path)).toList();
    }
    setState(() {});
  }

  Future<void> _saveImage(String url) async {
    final imageName = url.substring(url.lastIndexOf("/") + 1);
    final response = await get(Uri.parse(url));
    File image = File(path.join(imagesPath, imageName));
    await image.writeAsBytes(response.bodyBytes);
    setState(() {
      images?.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            images == null || images?.isEmpty == true
                ? const Center(
                    child: Text('No saved images'),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final image = images!.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.file(
                              image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                      itemCount: images?.length,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _inputController,
                    decoration:
                        const InputDecoration(label: Text('Enter image link')),
                  )),
                  ElevatedButton(
                      onPressed: () async {
                        _saveImage(_inputController.text);
                        _inputController.text = '';
                      },
                      child: const Text('Save'))
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
