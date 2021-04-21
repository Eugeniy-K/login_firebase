

import 'package:equatable/equatable.dart';
import 'package:login_firebase/models/film.dart';

abstract class FilmsState extends Equatable {
  const FilmsState();

  @override
  List<Object> get props => [];
}

class FilmsLoading extends FilmsState {}

class FilmsLoaded extends FilmsState {
  final List<Film> films;

  const FilmsLoaded([this.films = const []]);

  @override
  List<Object> get props => [films];

  @override
  String toString() => 'TodosLoadSuccess { todos: $films }';
}

class FilmsNotLoaded extends FilmsState {}