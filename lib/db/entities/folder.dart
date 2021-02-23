import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("FolderData")
class Folder extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get folderName => text()();
  IntColumn get count => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
