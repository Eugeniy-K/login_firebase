import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_firebase/entities/film_entity.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/repositories/films_repository.dart';

class FirebaseFilmsRepository implements FilmsRepository {

  final filmCollection = FirebaseFirestore.instance.collection('films');
  final filmCollection2 = FirebaseFirestore.instance.collection('users');
  final fireUser = FirebaseAuth.instance.currentUser;

  // @override
  // Future<void> addNewFilm(Film film) {
  //   return filmCollection2.doc(fireUser?.uid).collection('films')
  //       .add(film.toEntity().toDocument());
  // }
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

  // @override
  // Stream<List<Film>> films() async* {
  //   List<Film> films = [];
  //    filmCollection2.get().then((querySnap) {
  //     querySnap.docs.forEach((element) {
  //       filmCollection2.doc(fireUser?.uid).collection('films')
  //           .get().then((querySnap) {
  //             querySnap.docs
  //                 .forEach((element) {
  //                   films.add(Film.fromEntity(FilmEntity.fromSnapshot(element)));
  //                   } );
  //             return films;
  //       });
  //     });
  //   });

  // @override
  // Stream<List<Film>> films() async* {
  //   filmCollection2.doc(fireUser?.uid).get().then((value) {
  //     filmCollection.snapshots().map((snapshot) async*{
  //       var tmp = snapshot.docs
  //           .map((doc) => Film.fromEntity(FilmEntity.fromSnapshot(doc)))
  //           .toList();
  //       yield tmp;
  //     });
  //   });
  // }

}