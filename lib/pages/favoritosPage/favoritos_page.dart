import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/favoritosPage/favoritos_bloc.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/components/movieCard_item.dart';
import 'package:movies/utils/constants.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  FavoritosBloc bloc = FavoritosBloc();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    bloc.getFavorito();
    debugPrint("ENTRANDO NA TELA DE FAVORITOS");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("SAINDO DA TELA DE FAVORITOS");
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      bloc.getFavorito();
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
      appBar: myAppBar("Favoritos"),
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
            stream: bloc.favStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var movies = snapshot.data;
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
                      "Você ainda não tem filmes favoritados!",
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
