import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
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

  static Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var response = await db.insert(table, row);
    debugPrint("SALVOU - $response");
    return response;
  }

  static Future<List<Map<String, dynamic>>> getAllMovies() async {
    Database db = await instance.database;
    var response = await db.query(table);
    print(response);
    return response;
  }

  static Future<bool> checkMovieById(Movie movie) async {
    Database db = await instance.database;
    List<Map> maps = await db
        .rawQuery('SELECT (*) FROM $table WHERE $columnId = ${movie.id}');
    if (maps.length > 0) {
      debugPrint("true");
      return true;
    } else {
      debugPrint("false");
      return false;
    }
  }

  static Future<int> getRowCount() async {
    Database db = await instance.database;
    var response =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    debugPrint("TOTAL DE LINHAS: " + response.toString());
    return response;
  }

  static Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    var response =
        await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
    debugPrint("ATUALIZOU");
    return response;
  }

  static Future<int> delete(int id) async {
    Database db = await instance.database;
    var response =
        await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    debugPrint("DELETOU");
    return response;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
