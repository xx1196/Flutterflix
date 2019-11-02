import 'dart:convert';

import 'package:flutterflix/src/Models/Movie.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'd90f883e396197afa8e96a520bddab08';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });
    
    return processResponse(url);
  }
}
