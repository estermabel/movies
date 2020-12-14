import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customDio.dart';

class MovieRepository {
  var getNowPlayingUrl = "$kBASE_URL/movie/now_playing";
  var getMoviesUrl = "$kBASE_URL/discover/movie";
  var getPopularUrl = "$kBASE_URL/movie/popular";

  final CustomDio _dio = CustomDio();

  Future<List<Movie>> getMovies() async {
    var parametros = {"api_key": kCHAVE, "language": "en-US", "page": 1};
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
