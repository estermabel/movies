import 'dart:async';

import 'package:movies/models/movie_model.dart';
import 'package:movies/utils/customSharedPreferences.dart';

class FavoritosBloc {
  final StreamController<List<Movie>> _favController = StreamController();
  Stream<List<Movie>> get favStream => _favController.stream;
  Sink<List<Movie>> get favSink => _favController.sink;

  dispose() {
    _favController.close();
  }

  Future getFavorito(Movie movie) async {
    await CustomSharedPreferences.read("movies").then((read) async {
      if (read != null) {
        var moviesList = Movie.decode(read);
        favSink.add(moviesList);
      }
      favSink.add(List<Movie>());
    });
  }
}
