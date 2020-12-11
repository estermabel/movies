import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/moviePage/movie_page_bloc.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/constants.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({
    Key key,
    @required this.movie,
  }) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieBloc bloc = MovieBloc();

  @override
  void initState() {
    super.initState();
    debugPrint("ENTRANDO NA TELA DO FILME");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("SAINDO DA TELA DO FILME");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        color: LIGHT_BLUE,
        child: Column(
          children: [
            Hero(
              tag: '${widget.movie.id}',
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: SALMON,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: SALMON,
                      thickness: 1.5,
                      endIndent: 10,
                      indent: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Nota: ",
                            style: TextStyle(
                              color: Colors.cyan[200],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.movie.voteAverage}",
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: SALMON,
                      thickness: 1.5,
                      endIndent: 10,
                      indent: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Descrição:",
                        style: TextStyle(
                          color: Colors.cyan[200],
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.movie.overview}",
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Divider(
                      color: SALMON,
                      thickness: 1.5,
                      endIndent: 10,
                      indent: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Data de Lançamento:",
                        style: TextStyle(
                          color: Colors.cyan[200],
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.movie.releaseDate}",
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
