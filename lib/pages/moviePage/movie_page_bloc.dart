import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies/api/video_repository.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/video_model.dart';
import 'package:movies/utils/customSharedPreferences.dart';

class MovieBloc {
  final VideoRepository repository;
  StreamController<Video> _videoController = StreamController();
  Stream<Video> get videoStream => _videoController.stream;
  Sink<Video> get videoSink => _videoController.sink;

  StreamController<bool> _favButtonController = StreamController();
  Stream<bool> get favButtonStream => _favButtonController.stream;
  Sink<bool> get favButtonSink => _favButtonController.sink;

  List<Movie> moviesList;

  MovieBloc(this.repository);

  getVideo(int movieId) async {
    var response = await repository.getVideo(movieId);
    if (response != null) {
      videoSink.add(response);
    }
  }

  Future saveFavorito(Movie movie) async {
    if (moviesList != null) {
      moviesList.add(movie);
      favButtonSink.add(true);
      await CustomSharedPreferences.save("movies", Movie.encode(moviesList));
    } else {
      moviesList.add(movie);
      favButtonSink.add(true);
      await CustomSharedPreferences.save("movies", Movie.encode(moviesList));
    }
  }

  Future checkFavorito(Movie movie) async {
    await CustomSharedPreferences.read("movies").then((read) async {
      if (read != null) {
        moviesList = Movie.decode(read);
        var containsMovie = moviesList.firstWhere(
            (element) => element.id == movie.id,
            orElse: () => null);
        if (containsMovie != null) {
          favButtonSink.add(true);
        } else {
          favButtonSink.add(false);
        }
      } else {
        moviesList = new List<Movie>();
        favButtonSink.add(false);
      }
    });
  }

  Future<bool> handleFavorito(Movie movie) async {
    var containsMovie = moviesList
        .firstWhere((element) => element.id == movie.id, orElse: () => null);
    if (containsMovie != null) {
      return true;
    }
    return false;
  }

  removeFavorito(Movie movie) async {
    moviesList.remove(movie);
    favButtonSink.add(false);
    await CustomSharedPreferences.save("movies", Movie.encode(moviesList));
    debugPrint("DELETOU");
  }

  dispose() {
    _videoController.close();
    _favButtonController.close();
  }
}
