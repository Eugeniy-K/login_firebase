import 'package:bloc/bloc.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_event.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_state.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/repositories/api_film_repository.dart';

class FilmsApiBloc extends Bloc<FilmsApiEvent, FilmsApiState> {
  ApiFilmRepository apiFilmRepository;

  FilmsApiBloc({required this.apiFilmRepository}) : super(FilmsApiLoads());

  @override
  Stream<FilmsApiState> mapEventToState(FilmsApiEvent event) async* {
    if (event is FilmsApiRequested) {
      yield FilmsApiLoads();
      try {
        final List<Film> apiFilms = await apiFilmRepository.getFilms();
        yield FilmsApiLoadSuccess(apiFilms: apiFilms);
      } catch (_) {
        yield FilmsApiFailure();
      }
    }
  }

}