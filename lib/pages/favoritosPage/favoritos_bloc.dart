import 'dart:async';

import 'package:movies/models/movie_model.dart';

class FavoritosBloc {
  final StreamController<List<Movie>> _favController = StreamController();
  Stream<List<Movie>> get favStream => _favController.stream;
  Sink<List<Movie>> get favSink => _favController.sink;

  dispose() {
    _favController.close();
  }
}
