import 'package:flutter/material.dart';
import 'package:flutterflix/src/Models/Movie.dart';
import 'package:flutterflix/src/Providers/MovieProvider.dart';
import 'package:flutterflix/src/widget/card_swiper_widget.dart';
import 'package:flutterflix/src/widget/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Películas en cines'),
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperCards(), _footer(context)],
          ),
        ));
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getInCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Más Populares',
                style: Theme.of(context).textTheme.subhead,
              )),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: moviesProvider.getPopulars(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
