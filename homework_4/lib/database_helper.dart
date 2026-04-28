import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'movie.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static const String _dbName = 'movies.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'movies';

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  /// Creates the [movies] table on first launch.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        title       TEXT    NOT NULL,
        plot        TEXT    NOT NULL,
        genre       TEXT    NOT NULL,
        actors      TEXT    NOT NULL,
        poster      TEXT    NOT NULL,
        imdbRating  REAL    NOT NULL
      )
    ''');
  }

  // ── CRUD operations ────────────────────────────────────────────────────────

  /// Inserts a [Movie] and returns its new row id.
  ///
  /// Uses [ConflictAlgorithm.ignore] so re-inserting an existing row is a
  /// silent no-op (safe to call every time movies are loaded from the API).
  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return db.insert(
      _tableName,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  /// Returns every row in the [movies] table, ordered by title.
  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final rows = await db.query(_tableName, orderBy: 'title ASC');
    return rows.map(Movie.fromMap).toList();
  }

  /// Returns movies whose title contains [query] (case-insensitive).
  Future<List<Movie>> searchMoviesByTitle(String query) async {
    final db = await database;
    final rows = await db.query(
      _tableName,
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'title ASC',
    );
    return rows.map(Movie.fromMap).toList();
  }
}
