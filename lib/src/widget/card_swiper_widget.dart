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
		
		return Container(
				padding: EdgeInsets.only(top: 12.0),
				child: Swiper(
					itemWidth: _screenSize.width * .7,
					itemHeight: _screenSize.height * .5,
					layout: SwiperLayout.STACK,
					itemBuilder: (BuildContext context, int index) {
					  movies[index].uniqueId = '${movies[index].id}-tarjeta';
						return Hero(
							tag: movies[index].uniqueId,
							child: ClipRRect(
									borderRadius: BorderRadius.circular(20.0),
									child: GestureDetector(
										onTap: () => Navigator.pushNamed(context, 'detail', arguments: movies[index]),
										child: FadeInImage(
											image: NetworkImage(movies[index].getPosterImg()),
											placeholder: AssetImage('assets/img/no-image.jpg'),
											fit: BoxFit.cover,
										),
									)
							),
						);
					},
					itemCount: movies.length,
				));
	}
}
