import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}
