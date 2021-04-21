import 'dart:async';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/provider/film_api_client.dart';
import 'package:meta/meta.dart';

class ApiFilmRepository {
  final FilmApiClient filmApiClient;

  ApiFilmRepository({required this.filmApiClient});

  Future<List<Film>> getFilms() async {
    return filmApiClient.fetchFilms();
  }
}