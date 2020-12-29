import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "movies";
  static final _databaseVersion = 1;

  static final table = 'favoritos';
  static final columnId = 'id';
  static final columnBackdropPath = 'backdropPath';
  static final columnOriginalLanguage = 'originalLanguage';
  static final columnOriginalTitle = 'originalTitle';
  static final columnOverview = 'overview';
  static final columnPopularity = 'popularity';
  static final columnPosterPath = 'posterPath';
  static final columnReleaseDate = 'releaseDate';
  static final columnTitle = 'title';
  static final columnVoteAverage = 'voteAverage';
  static final columnVideo = 'video';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnOriginalLanguage TEXT NOT NULL,
            $columnOriginalTitle TEXT NOT NULL,
            $columnOriginalTitle TEXT NOT NULL,
            $columnOverview TEXT NOT NULL,
            $columnPopularity INTEGER NOT NULL,
            $columnPosterPath TEXT NOT NULL,
            $columnReleaseDate TEXT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnVoteAverage  DOUBLE NOT NULL,
            $columnVideo BOOL NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
