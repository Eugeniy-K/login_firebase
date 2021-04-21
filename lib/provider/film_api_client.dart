import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_firebase/models/film.dart';

class FilmApiClient {
  static const baseUrl = 'https://api.themoviedb.org/3/search/movie?api_key=';
  static const query = '&query=movie&page=1';
  static const token3 = 'df5847aebb2554be673e30fb73874d48';
  static const token4 = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZjU4NDdhZWJiMjU1NGJlNjczZTMwZmI3Mzg3NGQ0OCIsInN1YiI6IjYwN2Q1NTI0YzI4MjNhMDA3NmE4ZTBkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wkX5yPKTWBIlZT4WjclMeZIPtspfjDFpRn-0qvnwOtI';
  final http.Client httpClient;

  FilmApiClient({required this.httpClient});

  Future<List<Film>> fetchFilms() async {
    final filmsResponse = await this.httpClient.get(Uri.parse(baseUrl + token3 + query));

    if (filmsResponse.statusCode != 200) {
      throw Exception('error getting films');
    }

    var filmsJson = jsonDecode(filmsResponse.body)['results'] as List;
    List<Film> films = filmsJson.map((film) => Film.fromJson(film)).toList();

    return films;
  }
}