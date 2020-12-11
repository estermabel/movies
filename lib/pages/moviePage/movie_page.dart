import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/utils/components/appBar_item.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({Key key, this.movie}) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
    );
  }
}
