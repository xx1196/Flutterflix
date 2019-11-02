import 'dart:async';
import 'dart:convert';

import 'package:flutterflix/src/Models/Movie.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'd90f883e396197afa8e96a520bddab08';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';
  String _apiVersion = '3';
  int _popularsPage = 1;
  bool _loadingPopulars = false;
  List<Movie> _populars = List();
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  //Agregar datos al stream
  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  //Get para obtener los datos del stream
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInCinemas() async {
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loadingPopulars) return [];
    
    final url = Uri.https(_url, '$_apiVersion/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString(),
    });
    _loadingPopulars = true;
    _popularsPage++;

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);
    _loadingPopulars = false;
    return resp;
  }
}
