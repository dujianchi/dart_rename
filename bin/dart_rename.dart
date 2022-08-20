import 'dart:io';

import 'package:dart_rename/dart_rename.dart' as dart_rename;

void main(List<String> arguments) {
  if (arguments.length != 3) {
    print('Usage: dart_rename.dart <dir> <pattern> <newName>');
    return;
  }
  // arguments = ['/Users/air/Downloads/RuoYi-Vue-Plus-v4.2.0', 'RuoYi', 'Base'];

  if (arguments[0].endsWith('.') ||
      arguments[0].endsWith('.${Platform.pathSeparator}')) {
    arguments[0] = Directory.current.path;
  }
  print('path = ${Directory(arguments[0]).absolute.path}');

  dart_rename.renameDirectories(arguments[0], arguments[1], arguments[2]);

  dart_rename.renameFiles(arguments[0], arguments[1], arguments[2]);

  dart_rename.replaceFileContents(arguments[0], arguments[1], arguments[2]);
}
