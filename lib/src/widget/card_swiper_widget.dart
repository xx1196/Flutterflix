import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterflix/src/Models/Movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  int _indexMovie = 0;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _card = Container(
        padding: EdgeInsets.only(top: 12.0),
        child: Swiper(
          itemWidth: _screenSize.width * .7,
          itemHeight: _screenSize.height * .5,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            _indexMovie = index;
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movies[index].getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: movies.length,
        ));
    return GestureDetector(
      onTap: () {
        _indexMovie = _indexMovie - 1;
        if (_indexMovie < 0) _indexMovie = movies.length - 1;
        Navigator.pushNamed(context, 'detail', arguments: movies[_indexMovie]);
      },
      child: _card,
    );
  }
}
