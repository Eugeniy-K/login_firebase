

import 'package:equatable/equatable.dart';
import 'package:login_firebase/models/film.dart';

abstract class FilmsEvent extends Equatable {
  const FilmsEvent();

  @override
  List<Object> get props => [];
}

class LoadFilms extends FilmsEvent {}

class AddFilm extends FilmsEvent {
  final Film film;

  const AddFilm(this.film);

  @override
  List<Object> get props => [film];

  @override
  String toString() => 'FilmAdded { todo: $film }';
}

class UpdateFilm extends FilmsEvent {
  final Film film;

  const UpdateFilm(this.film);

  @override
  List<Object> get props => [film];

  @override
  String toString() => 'FilmUpdated { todo: $film }';
}

class DeleteFilm extends FilmsEvent {
  final Film film;

  const DeleteFilm(this.film);

  @override
  List<Object> get props => [film];

  @override
  String toString() => 'FilmDeleted { todo: $film }';
}

class ClearCompleted extends FilmsEvent {}

// class ToggleAll extends FilmsEvent {}

class FilmsUpdatedEvent extends FilmsEvent {
  final List<Film> films;

  FilmsUpdatedEvent(this.films);

  @override
  List<Object> get props => [films];
}