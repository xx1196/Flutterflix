import 'package:flutter/material.dart';
import 'package:flutterflix/src/Providers/MovieProvider.dart';
import 'package:flutterflix/src/widget/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Películas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[_swiperCards()],
          ),
        ));
  }

  Widget _swiperCards() {
    final moviesProvider = MoviesProvider();
    moviesProvider.getInCinemas();
    return CardSwiper(
      movies: [1, 2, 3, 4, 5],
    );
  }
}
