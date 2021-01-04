import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movies/api/video_repository.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/results_model.dart';
import 'package:movies/models/video_model.dart';
import 'package:movies/pages/favoritosPage/favoritos_bloc.dart';
import 'package:movies/pages/moviePage/movie_page_bloc.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/components/cashedImage_item.dart';
import 'package:movies/utils/components/youtubeVideo_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/helpers/helpers.dart';

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
  MovieBloc bloc = MovieBloc(VideoRepository());
  Video video;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    bloc.checkFavorito(widget.movie);
    debugPrint("ENTRANDO NA TELA DO FILME: -- ${widget.movie.title} --");
    if (widget.movie.id != null) {
      bloc.getVideo(widget.movie.id);
    }
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    debugPrint("SAINDO DA TELA DO FILME: -- ${widget.movie.title} --");
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      bloc.checkFavorito(widget.movie);
      if (widget.movie.id != null) {
        bloc.getVideo(widget.movie.id);
      }
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.movie.title),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        animSpeedFactor: 1.2,
        springAnimationDurationInMilliseconds: 700,
        color: BLUE,
        backgroundColor: SALMON,
        child: Container(
          color: LIGHT_BLUE,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Hero(
                    tag: '${widget.movie.id}',
                    child: CashedImage(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      border: 0.0,
                      url:
                          'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: StreamBuilder<bool>(
                        initialData: false,
                        stream: bloc.favButtonStream,
                        builder: (context, snapshot) {
                          return FloatingActionButton(
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              await bloc
                                  .handleFavorito(widget.movie)
                                  .then((value) {
                                if (value == true) {
                                  bloc.removeFavorito(widget.movie);
                                } else {
                                  bloc.saveFavorito(widget.movie);
                                }
                              });
                            },
                            backgroundColor: (snapshot.data != null)
                                ? snapshot.data
                                    ? BLUE
                                    : SALMON
                                : BLUE,
                            elevation: 15,
                            child: Icon(
                              (snapshot.data != null)
                                  ? snapshot.data
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined
                                  : Icons.favorite,
                              color: (snapshot.data != null)
                                  ? snapshot.data
                                      ? SALMON
                                      : DARK_BLUE
                                  : SALMON,
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
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
                            SelectableText(
                              "Nota: ",
                              style: TextStyle(
                                color: Colors.cyan[200],
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SelectableText(
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
                        child: SelectableText(
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
                        child: SelectableText(
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
                        child: SelectableText(
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
                        child: SelectableText(
                          Helpers.formatDate(
                            "${widget.movie.releaseDate}",
                          ),
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 17,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: bloc.videoStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            video = snapshot.data;
                            List<Result> results = video.results;
                            if (results.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    color: SALMON,
                                    thickness: 1.5,
                                    endIndent: 10,
                                    indent: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SelectableText(
                                      "Trailer:",
                                      style: TextStyle(
                                        color: Colors.cyan[200],
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                        YoutubeVideoItem(id: results.first.key),
                                  ),
                                ],
                              );
                            } else {
                              return Text("Filme não tem trailer!");
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: SALMON,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
