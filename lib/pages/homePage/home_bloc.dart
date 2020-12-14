import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/api/movie_repository.dart';
import 'package:movies/models/movie_model.dart';

class HomeBloc {
  final MovieRepository repository;
  StreamController<List<Movie>> _moviesController = StreamController();
  Stream<List<Movie>> get moviesStream => _moviesController.stream;
  Sink<List<Movie>> get moviesSink => _moviesController.sink;

  HomeBloc(this.repository);

  getMovies() async {
    var response = await repository.getMovies();
    if (response != null) {
      moviesSink.add(response);
    }
  }

  dispose() {
    _moviesController.close();
  }
}
