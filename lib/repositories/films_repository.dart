import 'dart:async';

import 'package:login_firebase/models/film.dart';

abstract class FilmsRepository {
  Future<void> addNewFilm(Film todo);

  Future<void> deleteFilm(Film todo);

  Stream<List<Film>> films();

  Future<void> updateFilm(Film todo);
}