import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_firebase/entities/film_entity.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/repositories/films_repository.dart';

class FirebaseFilmsRepository implements FilmsRepository {

  final filmCollection = FirebaseFirestore.instance.collection('films');

  @override
  Future<void> addNewFilm(Film film) {
    return filmCollection.add(film.toEntity().toDocument());
  }

  @override
  Future<void> deleteFilm(Film film) async {
    return filmCollection.doc(film.id).delete();
  }

  @override
  Stream<List<Film>> films() {
    return filmCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Film.fromEntity(FilmEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateFilm(Film update) {
    return filmCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}