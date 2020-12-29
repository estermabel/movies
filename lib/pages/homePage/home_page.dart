import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movies/api/movie_repository.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/favoritosPage/favoritos_page.dart';
import 'package:movies/pages/homePage/home_bloc.dart';
import 'package:movies/pages/moviePage/movie_page.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/components/movieCard_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeBloc(MovieRepository());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    debugPrint("ENTRANDO NA TELA HOME");
    bloc.getMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    debugPrint("SAINDO DA TELA HOME");
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      bloc.getMovies();
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
      appBar: myAppBar("Home"),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        animSpeedFactor: 1.2,
        springAnimationDurationInMilliseconds: 700,
        color: BLUE,
        backgroundColor: SALMON,
        child: Container(
          color: DARK_BLUE,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<List<Movie>>(
            stream: bloc.moviesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Movie> movies = snapshot.data;
                if (movies.isNotEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return movieCard(context, movies[index]);
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Ainda não temos filmes disponíveis!",
                      style: TextStyle(
                        color: SALMON,
                      ),
                    ),
                  );
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
        ),
      ),
    );
  }
}
