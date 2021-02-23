import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("FileData")
class Files extends Table {
  TextColumn get path => text()();
  TextColumn get album => text().nullable()();
  TextColumn get artist => text().nullable()();
  TextColumn get dateAdded => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get duration => text().nullable()();
  TextColumn get size => text().nullable()();
  TextColumn get thumbnailFile => text().nullable()();

  IntColumn get folderId =>
      integer().customConstraint("NULL REFERENCES FolderData(id)")();

  @override
  Set<Column> get primaryKey => {path};
}
