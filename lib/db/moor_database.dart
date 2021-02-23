import 'dart:convert';

import 'package:moor_flutter/moor_flutter.dart';

import 'entities/entities.dart';

part 'moor_database.g.dart';

class ListInColumnConverter extends TypeConverter<List<int>, String> {
  const ListInColumnConverter();
  @override
  List<int> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return (jsonDecode(fromDb) as List<dynamic>).cast<int>();
  }

  @override
  String mapToSql(List<int> value) {
    return jsonEncode(value);
  }
}

@UseMoor(tables: [Folder, Files], daos: [FilesDao, FolderDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
        )));

  @override
  int get schemaVersion => 2;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          for (var table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        },
      );
}

@UseDao(tables: [Folder])
class FolderDao extends DatabaseAccessor<AppDatabase> with _$FolderDaoMixin {
  final AppDatabase db;

  FolderDao(this.db) : super(db);

  Future<int> insertFolder(FolderData folderData) async {
    FolderData existingTable = await (select(folder)
          ..where((tbl) => tbl.folderName.equals(folderData.folderName)))
        .getSingle();
    if (existingTable != null) {
      update(folder).replace(FolderData(
          id: existingTable.id,
          folderName: folderData.folderName,
          count: folderData.count));
      return existingTable.id;
    } else {
      return into(folder).insert(folderData);
    }
  }

  Stream<List<FolderData>> watchAllfolders() => ((select(folder)
        ..orderBy([
          (t) => OrderingTerm(expression: t.folderName, mode: OrderingMode.asc)
        ])))
      .watch();
}

@UseDao(tables: [Files])
class FilesDao extends DatabaseAccessor<AppDatabase> with _$FilesDaoMixin {
  final AppDatabase db;
  FilesDao(this.db) : super(db);

  Future<FileData> fetchFileWithPath(String path) async {
    return await (select(files)..where((tbl) => tbl.path.equals(path)))
        .getSingle();
  }

  void insertFiles(FileData fileData) async {
    await into(files).insert(fileData, orReplace: true);
  }

  Future<List<FileData>> fetchFilesByFolderId(int folderId) {
    return (select(files)..where((tbl) => tbl.folderId.equals(folderId))).get();
  }

  void updateThumbnail(FileData fileData, String thumbnailFile) {
    update(files)
      ..where((tbl) => tbl.path.equals(fileData.path))
      ..write(FilesCompanion(thumbnailFile: Value(thumbnailFile)));
  }
}
