import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 12.0),
        child: Swiper(
          itemWidth: _screenSize.width * .7,
          itemHeight: _screenSize.height * .5,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                "http://via.placeholder.com/350x150",
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: movies.length,
        ));
  }
}
