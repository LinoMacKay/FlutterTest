import 'package:flutter/cupertino.dart';
import 'package:test/model/movie.dart';
import 'package:test/service/movieService.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> movies = [];
  MovieService movieService = MovieService();
  getAllMovies() async {
    movies = await movieService.getAllMovies();
    notifyListeners();
  }
}
