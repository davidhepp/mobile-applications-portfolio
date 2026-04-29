import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import '../movie.dart';

abstract class MovieRepository {
  Future<void> initialize();
  Future<List<Movie>> getAllMovies();
  Future<List<Movie>> searchMoviesByTitle(String query);
}

class SqliteMovieRepository implements MovieRepository {
  SqliteMovieRepository._internal();

  static final SqliteMovieRepository instance =
      SqliteMovieRepository._internal();

  static const String _assetPath = 'lib/db/movie_data.json';
  static const String _databaseName = 'movies.db';
  static const String _tableName = 'movies';
  static const int _databaseVersion = 2;

  Database? _database;

  Future<void> _initDatabaseFactory() async {
    if (Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  Future<Database> get _db async {
    await _initDatabaseFactory();
    _database ??= await _openDatabase();
    return _database!;
  }

  @override
  Future<void> initialize() async {
    final db = await _db;
    await _seedMovies(db);
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    final db = await _db;
    final rows = await db.query(_tableName, orderBy: 'title ASC');
    return rows.map(Movie.fromMap).toList();
  }

  @override
  Future<List<Movie>> searchMoviesByTitle(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return getAllMovies();
    }

    final db = await _db;
    final rows = await db.query(
      _tableName,
      where: 'title LIKE ?',
      whereArgs: ['%$trimmedQuery%'],
      orderBy: 'title ASC',
    );
    return rows.map(Movie.fromMap).toList();
  }

  Future<Database> _openDatabase() async {
     if (Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async => _createMoviesTable(db),
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_tableName');
        await _createMoviesTable(db);
      },
    );
  }

  Future<void> _createMoviesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imdbId TEXT NOT NULL UNIQUE,
        title TEXT NOT NULL,
        plot TEXT NOT NULL,
        genre TEXT NOT NULL,
        actors TEXT NOT NULL,
        poster TEXT NOT NULL,
        imdbRating REAL NOT NULL
      )
    ''');
  }

  Future<void> _seedMovies(Database db) async {
    final rawJson = await rootBundle.loadString(_assetPath);
    final jsonList = jsonDecode(rawJson) as List<dynamic>;
    final movies = jsonList
        .map((item) => Movie.fromJson(item as Map<String, dynamic>))
        .toList();

    final batch = db.batch();
    for (final movie in movies) {
      batch.insert(
        _tableName,
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }
}
