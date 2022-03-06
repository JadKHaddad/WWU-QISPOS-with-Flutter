import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> loadStyle() async {
  return await rootBundle.loadString('assets/css/style.css');
}

/*
* must delete
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/file.html');
}

Future<File> write(String content) async {
  final file = await _localFile;
  return file.writeAsString(content);
}
*/

