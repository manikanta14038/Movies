import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService extends ChangeNotifier {
  String topRatedUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=8561ac90901236d3888023b8e21667fc&language=en-US&page=1';
  String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=8561ac90901236d3888023b8e21667fc&language=en-US';

  var movies = [];
  var genres = [];
  var genresData = [];
  var topRatedMovies = [];
  DataService() {
    getTopRatedMovies();
  }

  getTopRatedMovies() async {
    http.Response data = await http.get('$topRatedUrl');
    var rated = json.decode(data.body);
    topRatedMovies = rated['results'];
    // print(topRatedMovies);
    notifyListeners();
  }

  getGenreData() async {
    http.Response id = await http.get('$genreUrl');
    var gen = json.decode(id.body);
    genresData = gen['genres'];
    notifyListeners();
    // print(genresData);
  }

  getChangedData(String val) async {
    http.Response res = await http.get(
        'https://api.themoviedb.org/3/search/movie?api_key=8561ac90901236d3888023b8e21667fc&language=en-US&page=1&query=$val');
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      movies = data['results'];
      // genres = data['results']['genre_ids'];
      notifyListeners();
    } else {
      movies=[];
      getTopRatedMovies();
      print(res.statusCode);
    }
  }
}
