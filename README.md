A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.  
 
### for build executable
```bash
dart compile exe bin/dart_rename.dart
```

### usage example  
```bash
# replace files name and content both
./dart_rename.exe "oldStr" "newStr"
```