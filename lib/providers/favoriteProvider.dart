import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/model/movie.dart';

class FavoriteProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  set movies(List<Movie> value) {
    _movies = value;
    notifyListeners();
  }

  static final FavoriteProvider dbProvider = FavoriteProvider();

  static Database? _database;
  Future<Database> get database async => _database ??= await createDatabase();

  createDatabase() async {
    var databasesPath = await getDatabasesPath();

    String path = databasesPath + "Moviesdb.db";

    var database = await openDatabase(path, version: 1, onCreate: initDB);
    return database;
  }

  Future initDB(Database database, int version) async {
    await database.execute(
        'CREATE TABLE Movies (id INTEGER PRIMARY KEY, title TEXT, rating TEXT, description TEXT,release TEXT, movieId TEXT, image TEXT, year TEXT)');
  }

  Future<void> insert(Movie movie) async {
    final db = await database;
    await db.insert(
      'Movies',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    movies.add(movie);
    notifyListeners();
  }

  Future<void> getMovies() async {
    var db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('movies');
    var favorites = List.generate(maps.length, (i) {
      return Movie(
          id: maps[i]['movieId'],
          description: maps[i]['description'],
          title: maps[i]['title'],
          rating: maps[i]['rating'],
          image: maps[i]['image'],
          year: maps[i]['year'],
          release: maps[i]['release']);
    });
    movies = favorites;
  }

  Future<void> delete(String id) async {
    final db = await database;

    await db.delete(
      'Movies',
      where: 'movieId = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<Movie?> find(String id) async {
    final db = await database;
    var result =
        await db.query("Movies", where: "movieId = ?", whereArgs: [id]);
    return result.length > 0 ? Movie.fromJson(result.first) : null;
  }

  Future close() async => _database!.close();
}
