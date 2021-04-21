import 'package:equatable/equatable.dart';
import 'package:login_firebase/models/film.dart';

abstract class FilmsApiState extends Equatable {
  const FilmsApiState();

  @override
  List<Object> get props => [];
}

class FilmsApiLoads extends FilmsApiState {}

class FilmsApiLoadSuccess extends FilmsApiState {
  final List<Film> apiFilms;

  FilmsApiLoadSuccess({required this.apiFilms});

  @override
  List<Object> get props => [apiFilms];
}

class FilmsApiFailure extends FilmsApiState {}