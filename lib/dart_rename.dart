import 'dart:io';

// replace files content that match the given pattern to the given replacement in given directory
void replaceFileContents(String dir, String pattern, String replacement) {
  for (var file
      in Directory(dir).listSync(recursive: true, followLinks: false)) {
    if (file is File) {
      try {
        var content = file.readAsStringSync();
        var newContent = content.replaceAll(pattern, replacement);
        if (newContent != content) {
          file.writeAsStringSync(newContent);
          print('replaced in ${file.path}');
        }
        // ignore: empty_catches
      } catch (e) {}
    }
  }
}

// find all directories in the given directory that name matches the given pattern, then rename them to the given new name
void renameDirectories(String dir, String pattern, String newName) {
  var directories = Directory(dir)
      .listSync(recursive: true, followLinks: false)
      .whereType<Directory>()
      .map((entity) => entity.absolute.path)
      .toList();
  for (var directory in directories) {
    if (directory.contains(pattern)) {
      _renameDir(directory, pattern, newName);
    }
  }
}

// find all files in the given directory that name matches the given pattern, then rename them to the given new name
void renameFiles(String dir, String pattern, String newName) {
  var files = Directory(dir)
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .map((entity) => entity.absolute.path)
      .toList();
  for (var file in files) {
    // get file name
    var fileName = file.split(Platform.pathSeparator).last;
    if (fileName.contains(pattern)) {
      // get file path without file name
      var filePath = file.substring(0, file.length - fileName.length);
      _renameFile(filePath, fileName, pattern, newName);
    }
  }
}

void _renameDir(String directory, String pattern, String newName) {
  var newDirectory = directory.replaceFirst(pattern, newName);
  if (Directory(directory).existsSync()) {
    try {
      Directory(directory).renameSync(newDirectory);
      print('renamed $directory to $newDirectory');
      // ignore: empty_catches
    } catch (e) {}
  } else if (newDirectory.contains(pattern)) {
    _renameDir(newDirectory, pattern, newName);
  }
}

void _renameFile(
    String filePath, String fileName, String pattern, String newName) {
  final file = '$filePath$fileName';
  if (File(file).existsSync()) {
    try {
      var newFile = fileName.replaceFirst(pattern, newName);
      File(file).renameSync('$filePath$newFile');
      print('renamed $file to $filePath$newFile');
      // ignore: empty_catches
    } catch (e) {}
  }
}
