// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class FolderData extends DataClass implements Insertable<FolderData> {
  final int id;
  final String folderName;
  final int count;
  FolderData(
      {@required this.id, @required this.folderName, @required this.count});
  factory FolderData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return FolderData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      folderName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_name']),
      count: intType.mapFromDatabaseResponse(data['${effectivePrefix}count']),
    );
  }
  factory FolderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return FolderData(
      id: serializer.fromJson<int>(json['id']),
      folderName: serializer.fromJson<String>(json['folderName']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'folderName': serializer.toJson<String>(folderName),
      'count': serializer.toJson<int>(count),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<FolderData>>(bool nullToAbsent) {
    return FolderCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      folderName: folderName == null && nullToAbsent
          ? const Value.absent()
          : Value(folderName),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
    ) as T;
  }

  FolderData copyWith({int id, String folderName, int count}) => FolderData(
        id: id ?? this.id,
        folderName: folderName ?? this.folderName,
        count: count ?? this.count,
      );
  @override
  String toString() {
    return (StringBuffer('FolderData(')
          ..write('id: $id, ')
          ..write('folderName: $folderName, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(folderName.hashCode, count.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is FolderData &&
          other.id == id &&
          other.folderName == folderName &&
          other.count == count);
}

class FolderCompanion extends UpdateCompanion<FolderData> {
  final Value<int> id;
  final Value<String> folderName;
  final Value<int> count;
  const FolderCompanion({
    this.id = const Value.absent(),
    this.folderName = const Value.absent(),
    this.count = const Value.absent(),
  });
  FolderCompanion copyWith(
      {Value<int> id, Value<String> folderName, Value<int> count}) {
    return FolderCompanion(
      id: id ?? this.id,
      folderName: folderName ?? this.folderName,
      count: count ?? this.count,
    );
  }
}

class $FolderTable extends Folder with TableInfo<$FolderTable, FolderData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FolderTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _folderNameMeta = const VerificationMeta('folderName');
  GeneratedTextColumn _folderName;
  @override
  GeneratedTextColumn get folderName => _folderName ??= _constructFolderName();
  GeneratedTextColumn _constructFolderName() {
    return GeneratedTextColumn(
      'folder_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  GeneratedIntColumn _count;
  @override
  GeneratedIntColumn get count => _count ??= _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, folderName, count];
  @override
  $FolderTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'folder';
  @override
  final String actualTableName = 'folder';
  @override
  VerificationContext validateIntegrity(FolderCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.folderName.present) {
      context.handle(_folderNameMeta,
          folderName.isAcceptableValue(d.folderName.value, _folderNameMeta));
    } else if (folderName.isRequired && isInserting) {
      context.missing(_folderNameMeta);
    }
    if (d.count.present) {
      context.handle(
          _countMeta, count.isAcceptableValue(d.count.value, _countMeta));
    } else if (count.isRequired && isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FolderData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FolderCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.folderName.present) {
      map['folder_name'] = Variable<String, StringType>(d.folderName.value);
    }
    if (d.count.present) {
      map['count'] = Variable<int, IntType>(d.count.value);
    }
    return map;
  }

  @override
  $FolderTable createAlias(String alias) {
    return $FolderTable(_db, alias);
  }
}

class FileData extends DataClass implements Insertable<FileData> {
  final String path;
  final String album;
  final String artist;
  final String dateAdded;
  final String displayName;
  final String duration;
  final String size;
  final String thumbnailFile;
  final int folderId;
  FileData(
      {@required this.path,
      this.album,
      this.artist,
      this.dateAdded,
      this.displayName,
      this.duration,
      this.size,
      this.thumbnailFile,
      @required this.folderId});
  factory FileData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return FileData(
      path: stringType.mapFromDatabaseResponse(data['${effectivePrefix}path']),
      album:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}album']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      dateAdded: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_added']),
      displayName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      duration: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      size: stringType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      thumbnailFile: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_file']),
      folderId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}folder_id']),
    );
  }
  factory FileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return FileData(
      path: serializer.fromJson<String>(json['path']),
      album: serializer.fromJson<String>(json['album']),
      artist: serializer.fromJson<String>(json['artist']),
      dateAdded: serializer.fromJson<String>(json['dateAdded']),
      displayName: serializer.fromJson<String>(json['displayName']),
      duration: serializer.fromJson<String>(json['duration']),
      size: serializer.fromJson<String>(json['size']),
      thumbnailFile: serializer.fromJson<String>(json['thumbnailFile']),
      folderId: serializer.fromJson<int>(json['folderId']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'path': serializer.toJson<String>(path),
      'album': serializer.toJson<String>(album),
      'artist': serializer.toJson<String>(artist),
      'dateAdded': serializer.toJson<String>(dateAdded),
      'displayName': serializer.toJson<String>(displayName),
      'duration': serializer.toJson<String>(duration),
      'size': serializer.toJson<String>(size),
      'thumbnailFile': serializer.toJson<String>(thumbnailFile),
      'folderId': serializer.toJson<int>(folderId),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<FileData>>(bool nullToAbsent) {
    return FilesCompanion(
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      album:
          album == null && nullToAbsent ? const Value.absent() : Value(album),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      dateAdded: dateAdded == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAdded),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      thumbnailFile: thumbnailFile == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailFile),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
    ) as T;
  }

  FileData copyWith(
          {String path,
          String album,
          String artist,
          String dateAdded,
          String displayName,
          String duration,
          String size,
          String thumbnailFile,
          int folderId}) =>
      FileData(
        path: path ?? this.path,
        album: album ?? this.album,
        artist: artist ?? this.artist,
        dateAdded: dateAdded ?? this.dateAdded,
        displayName: displayName ?? this.displayName,
        duration: duration ?? this.duration,
        size: size ?? this.size,
        thumbnailFile: thumbnailFile ?? this.thumbnailFile,
        folderId: folderId ?? this.folderId,
      );
  @override
  String toString() {
    return (StringBuffer('FileData(')
          ..write('path: $path, ')
          ..write('album: $album, ')
          ..write('artist: $artist, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('displayName: $displayName, ')
          ..write('duration: $duration, ')
          ..write('size: $size, ')
          ..write('thumbnailFile: $thumbnailFile, ')
          ..write('folderId: $folderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      path.hashCode,
      $mrjc(
          album.hashCode,
          $mrjc(
              artist.hashCode,
              $mrjc(
                  dateAdded.hashCode,
                  $mrjc(
                      displayName.hashCode,
                      $mrjc(
                          duration.hashCode,
                          $mrjc(
                              size.hashCode,
                              $mrjc(thumbnailFile.hashCode,
                                  folderId.hashCode)))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is FileData &&
          other.path == path &&
          other.album == album &&
          other.artist == artist &&
          other.dateAdded == dateAdded &&
          other.displayName == displayName &&
          other.duration == duration &&
          other.size == size &&
          other.thumbnailFile == thumbnailFile &&
          other.folderId == folderId);
}

class FilesCompanion extends UpdateCompanion<FileData> {
  final Value<String> path;
  final Value<String> album;
  final Value<String> artist;
  final Value<String> dateAdded;
  final Value<String> displayName;
  final Value<String> duration;
  final Value<String> size;
  final Value<String> thumbnailFile;
  final Value<int> folderId;
  const FilesCompanion({
    this.path = const Value.absent(),
    this.album = const Value.absent(),
    this.artist = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.displayName = const Value.absent(),
    this.duration = const Value.absent(),
    this.size = const Value.absent(),
    this.thumbnailFile = const Value.absent(),
    this.folderId = const Value.absent(),
  });
  FilesCompanion copyWith(
      {Value<String> path,
      Value<String> album,
      Value<String> artist,
      Value<String> dateAdded,
      Value<String> displayName,
      Value<String> duration,
      Value<String> size,
      Value<String> thumbnailFile,
      Value<int> folderId}) {
    return FilesCompanion(
      path: path ?? this.path,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      dateAdded: dateAdded ?? this.dateAdded,
      displayName: displayName ?? this.displayName,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      folderId: folderId ?? this.folderId,
    );
  }
}

class $FilesTable extends Files with TableInfo<$FilesTable, FileData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FilesTable(this._db, [this._alias]);
  final VerificationMeta _pathMeta = const VerificationMeta('path');
  GeneratedTextColumn _path;
  @override
  GeneratedTextColumn get path => _path ??= _constructPath();
  GeneratedTextColumn _constructPath() {
    return GeneratedTextColumn(
      'path',
      $tableName,
      false,
    );
  }

  final VerificationMeta _albumMeta = const VerificationMeta('album');
  GeneratedTextColumn _album;
  @override
  GeneratedTextColumn get album => _album ??= _constructAlbum();
  GeneratedTextColumn _constructAlbum() {
    return GeneratedTextColumn(
      'album',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  GeneratedTextColumn _artist;
  @override
  GeneratedTextColumn get artist => _artist ??= _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn(
      'artist',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateAddedMeta = const VerificationMeta('dateAdded');
  GeneratedTextColumn _dateAdded;
  @override
  GeneratedTextColumn get dateAdded => _dateAdded ??= _constructDateAdded();
  GeneratedTextColumn _constructDateAdded() {
    return GeneratedTextColumn(
      'date_added',
      $tableName,
      true,
    );
  }

  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  GeneratedTextColumn _displayName;
  @override
  GeneratedTextColumn get displayName =>
      _displayName ??= _constructDisplayName();
  GeneratedTextColumn _constructDisplayName() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedTextColumn _duration;
  @override
  GeneratedTextColumn get duration => _duration ??= _constructDuration();
  GeneratedTextColumn _constructDuration() {
    return GeneratedTextColumn(
      'duration',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedTextColumn _size;
  @override
  GeneratedTextColumn get size => _size ??= _constructSize();
  GeneratedTextColumn _constructSize() {
    return GeneratedTextColumn(
      'size',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thumbnailFileMeta =
      const VerificationMeta('thumbnailFile');
  GeneratedTextColumn _thumbnailFile;
  @override
  GeneratedTextColumn get thumbnailFile =>
      _thumbnailFile ??= _constructThumbnailFile();
  GeneratedTextColumn _constructThumbnailFile() {
    return GeneratedTextColumn(
      'thumbnail_file',
      $tableName,
      true,
    );
  }

  final VerificationMeta _folderIdMeta = const VerificationMeta('folderId');
  GeneratedIntColumn _folderId;
  @override
  GeneratedIntColumn get folderId => _folderId ??= _constructFolderId();
  GeneratedIntColumn _constructFolderId() {
    return GeneratedIntColumn('folder_id', $tableName, false,
        $customConstraints: 'NULL REFERENCES FolderData(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [
        path,
        album,
        artist,
        dateAdded,
        displayName,
        duration,
        size,
        thumbnailFile,
        folderId
      ];
  @override
  $FilesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'files';
  @override
  final String actualTableName = 'files';
  @override
  VerificationContext validateIntegrity(FilesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.path.present) {
      context.handle(
          _pathMeta, path.isAcceptableValue(d.path.value, _pathMeta));
    } else if (path.isRequired && isInserting) {
      context.missing(_pathMeta);
    }
    if (d.album.present) {
      context.handle(
          _albumMeta, album.isAcceptableValue(d.album.value, _albumMeta));
    } else if (album.isRequired && isInserting) {
      context.missing(_albumMeta);
    }
    if (d.artist.present) {
      context.handle(
          _artistMeta, artist.isAcceptableValue(d.artist.value, _artistMeta));
    } else if (artist.isRequired && isInserting) {
      context.missing(_artistMeta);
    }
    if (d.dateAdded.present) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableValue(d.dateAdded.value, _dateAddedMeta));
    } else if (dateAdded.isRequired && isInserting) {
      context.missing(_dateAddedMeta);
    }
    if (d.displayName.present) {
      context.handle(_displayNameMeta,
          displayName.isAcceptableValue(d.displayName.value, _displayNameMeta));
    } else if (displayName.isRequired && isInserting) {
      context.missing(_displayNameMeta);
    }
    if (d.duration.present) {
      context.handle(_durationMeta,
          duration.isAcceptableValue(d.duration.value, _durationMeta));
    } else if (duration.isRequired && isInserting) {
      context.missing(_durationMeta);
    }
    if (d.size.present) {
      context.handle(
          _sizeMeta, size.isAcceptableValue(d.size.value, _sizeMeta));
    } else if (size.isRequired && isInserting) {
      context.missing(_sizeMeta);
    }
    if (d.thumbnailFile.present) {
      context.handle(
          _thumbnailFileMeta,
          thumbnailFile.isAcceptableValue(
              d.thumbnailFile.value, _thumbnailFileMeta));
    } else if (thumbnailFile.isRequired && isInserting) {
      context.missing(_thumbnailFileMeta);
    }
    if (d.folderId.present) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableValue(d.folderId.value, _folderIdMeta));
    } else if (folderId.isRequired && isInserting) {
      context.missing(_folderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  FileData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FileData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(FilesCompanion d) {
    final map = <String, Variable>{};
    if (d.path.present) {
      map['path'] = Variable<String, StringType>(d.path.value);
    }
    if (d.album.present) {
      map['album'] = Variable<String, StringType>(d.album.value);
    }
    if (d.artist.present) {
      map['artist'] = Variable<String, StringType>(d.artist.value);
    }
    if (d.dateAdded.present) {
      map['date_added'] = Variable<String, StringType>(d.dateAdded.value);
    }
    if (d.displayName.present) {
      map['display_name'] = Variable<String, StringType>(d.displayName.value);
    }
    if (d.duration.present) {
      map['duration'] = Variable<String, StringType>(d.duration.value);
    }
    if (d.size.present) {
      map['size'] = Variable<String, StringType>(d.size.value);
    }
    if (d.thumbnailFile.present) {
      map['thumbnail_file'] =
          Variable<String, StringType>(d.thumbnailFile.value);
    }
    if (d.folderId.present) {
      map['folder_id'] = Variable<int, IntType>(d.folderId.value);
    }
    return map;
  }

  @override
  $FilesTable createAlias(String alias) {
    return $FilesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $FolderTable _folder;
  $FolderTable get folder => _folder ??= $FolderTable(this);
  $FilesTable _files;
  $FilesTable get files => _files ??= $FilesTable(this);
  FilesDao _filesDao;
  FilesDao get filesDao => _filesDao ??= FilesDao(this as AppDatabase);
  FolderDao _folderDao;
  FolderDao get folderDao => _folderDao ??= FolderDao(this as AppDatabase);
  @override
  List<TableInfo> get allTables => [folder, files];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$FolderDaoMixin on DatabaseAccessor<AppDatabase> {
  $FolderTable get folder => db.folder;
}

mixin _$FilesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FilesTable get files => db.files;
}
