import 'package:flutter/material.dart';
import 'package:flutterflix/src/Models/Movie.dart';
import 'package:flutterflix/src/Providers/MovieProvider.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = MoviesProvider();
  final movies = [
    'Spiderman',
    'Capitan america',
    'Batman',
    'Shazam!',
    'Iron man',
    'Aquaman'
  ];

  final recentMovies = [
    'Spiderman',
    'Capitan america',
    'Iron man',
    'Iron man 2'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Imagen a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son sugerencias de busqueda
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: moviesProvider.searchMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return ListView(
              children: movies.map((movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    movie.originalTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
