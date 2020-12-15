import 'package:flutter/material.dart';
import 'package:movies/api/movie_repository.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/favoritosPage/favoritos_page.dart';
import 'package:movies/pages/homePage/home_bloc.dart';
import 'package:movies/pages/moviePage/movie_page.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/components/movieCard_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/helpers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeBloc(MovieRepository());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Movies"),
      body: Container(
        color: DARK_BLUE,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<Movie>>(
          stream: bloc.moviesStream,
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
                  child: Text("Ainda não temos filmes disponíveis!"),
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
    );
  }
}
