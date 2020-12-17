import 'dart:convert';

import 'package:movies/models/video_model.dart';

class Movie {
  int id;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  bool video;

  Movie({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.video,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    video = json['video'];
  }

  static Map<String, dynamic> toJson([Movie movie]) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = movie.backdropPath;
    data['id'] = movie.id;
    data['original_language'] = movie.originalLanguage;
    data['original_title'] = movie.originalTitle;
    data['overview'] = movie.overview;
    data['popularity'] = movie.popularity;
    data['poster_path'] = movie.posterPath;
    data['release_date'] = movie.releaseDate;
    data['title'] = movie.title;
    data['vote_average'] = movie.voteAverage;
    data['video'] = movie.video;
    return data;
  }

  static String encode(List<Movie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => Movie.toJson(movie))
            .toList(),
      );

  static List<Movie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<Movie>((item) => Movie.fromJson(item))
          .toList();
}
