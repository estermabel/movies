import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/utils/customDio.dart';

class MovieRepository {
  final String apiKey = 'b110ece4de4ab7fee86d41cdad01500f';

  static String url = "https://api.themoviedb.org/3";
  var getNowPlayingUrl = "$url/movie/now_playing";
  var getMoviesUrl = "$url/discover/movie";
  var getPopularUrl = "$url/movie/popular";

  final CustomDio _dio = CustomDio();

  Future<List<Movie>> getMovies() async {
    var parametros = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: parametros);
      var list = (response.data["results"] as List)
          .map((item) => Movie.fromJson(item))
          .toList();
      return list;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
