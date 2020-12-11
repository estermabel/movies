import 'package:flutter/material.dart';
import 'package:movies/api/movie_repository.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/pages/homePage/home_bloc.dart';
import 'package:movies/pages/moviePage/movie_page.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/constants.dart';

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
    debugPrint("SAINDO DA TELA HOME");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        color: DARK_BLUE,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            StreamBuilder<List<Movie>>(
              stream: bloc.moviesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var movies = snapshot.data;
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return movieCard(movies[index]);
                      },
                    ),
                  );
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
    );
  }

  GestureDetector movieCard(Movie movie) {
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
        padding: const EdgeInsets.all(20.0),
        child: Container(
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
                      "${movie.releaseDate}",
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
}
