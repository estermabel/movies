import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/moviePage/movie_page.dart';

import '../constants.dart';
import '../helpers.dart';

GestureDetector movieCard(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviePage(movie: movie),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: LIGHT_BLUE,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset.fromDirection(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: '${movie.id}',
              child: Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                  color: SALMON,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 214,
                    child: Text(
                      "${movie.title}",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: SALMON,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Data de Lançamento:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    Helpers.formatDate("${movie.releaseDate}"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Nota:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${movie.voteAverage}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}