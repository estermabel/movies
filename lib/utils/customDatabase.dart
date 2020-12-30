import 'package:movies/models/movie_model.dart';

import 'helpers/db_helper.dart';

class CustomDatabase {
  static Future<int> inserir(Movie movie) async {
    return await DatabaseHelper.insert(movie.toMap());
  }

  static Future<List<Movie>> getAllMovies() async {
    final result = await DatabaseHelper.getAllMovies();
    List<Movie> movies;
    if (result.isNotEmpty) {
      if (result != null) {
        movies = result.map((e) => Movie.fromMap(e)).toList();
      } else {
        movies = List<Movie>.empty(growable: true);
      }
    } else {
      movies = List<Movie>.empty(growable: true);
    }
    return movies;
  }

  static Future<bool> checkMovieById(Movie movie) async {
    return await DatabaseHelper.checkMovieById(movie);
  }

  static void update(Movie movie) async {
    await DatabaseHelper.update(movie.toMap());
  }

  static Future<int> delete(Movie movie) async {
    return await DatabaseHelper.delete(movie.id);
  }
}
