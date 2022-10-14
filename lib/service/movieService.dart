import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/model/movie.dart';

class MovieService {
  final url = 'https://movies-app1.p.rapidapi.com/api/movies';
  Future<List<Movie>> getAllMovies() async {
    var headers = {
      'X-RapidAPI-Key': '680a1fb4d9msh314880e3a9e881cp1f68e7jsn0f180d4b1fe6',
      'X-RapidAPI-Host': 'movies-app1.p.rapidapi.com'
    };

    final uri = Uri.parse(this.url);
    final resp = await http.get(uri, headers: headers);
    if (resp.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(resp.body);

      List<dynamic> results = decodedJson['results'];

      List<Movie> movies = results.map((experienceJson) {
        return Movie.fromJson(experienceJson);
      }).toList();
      return movies;
    } else {
      return [];
    }
  }
}
