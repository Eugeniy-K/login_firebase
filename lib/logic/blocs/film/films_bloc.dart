import 'dart:async';
import 'films.dart';
import 'package:bloc/bloc.dart';
import 'package:login_firebase/repositories/films_repository.dart';


class FilmsBloc extends Bloc<FilmsEvent, FilmsState> {
  final FilmsRepository _filmsRepository;
  StreamSubscription? _filmsSubscription;

  FilmsBloc({required FilmsRepository filmsRepository})
      : assert(filmsRepository != null),
        _filmsRepository = filmsRepository,
        super(FilmsLoading());

  @override
  Stream<FilmsState> mapEventToState(FilmsEvent event) async* {
    if (event is LoadFilms) {
      yield* _mapLoadFilmsToState();
    } else if (event is AddFilm) {
      yield* _mapAddFilmToState(event);
    } else if (event is UpdateFilm) {
      yield* _mapUpdateFilmToState(event);
    } else if (event is DeleteFilm) {
      yield* _mapDeleteFilmToState(event);
    // } else if (event is ToggleAll) {
    //   yield* _mapToggleAllToState();
    // } else if (event is ClearCompleted) {
    //   yield* _mapClearCompletedToState();
    } else if (event is FilmsUpdated) {
      yield* _mapFilmsUpdateToState(event);
    }
  }

  Stream<FilmsState> _mapLoadFilmsToState() async* {
    _filmsSubscription?.cancel();
    _filmsSubscription = _filmsRepository.films().listen(
          (films) => add(FilmsUpdated(films)),
    );
  }

  Stream<FilmsState> _mapAddFilmToState(AddFilm event) async* {
    _filmsRepository.addNewFilm(event.film);
  }

  Stream<FilmsState> _mapUpdateFilmToState(UpdateFilm event) async* {
    _filmsRepository.updateFilm(event.film);
  }

  Stream<FilmsState> _mapDeleteFilmToState(DeleteFilm event) async* {
    _filmsRepository.deleteFilm(event.film);
  }

  // Stream<FilmsState> _mapToggleAllToState() async* {
  //   final currentState = state;
  //   if (currentState is FilmsLoaded) {
  //     final allComplete = currentState.todos.every((todo) => todo.complete);
  //     final List<Todo> updatedTodos = currentState.todos
  //         .map((todo) => todo.copyWith(complete: !allComplete))
  //         .toList();
  //     updatedTodos.forEach((updatedTodo) {
  //       _todosRepository.updateTodo(updatedTodo);
  //     });
  //   }
  // }

  // Stream<FilmsState> _mapClearCompletedToState() async* {
  //   final currentState = state;
  //   if (currentState is FilmsLoaded) {
  //     final List<Todo> completedTodos =
  //     currentState.todos.where((todo) => todo.complete).toList();
  //     completedTodos.forEach((completedTodo) {
  //       _todosRepository.deleteTodo(completedTodo);
  //     });
  //   }
  // }

  Stream<FilmsState> _mapFilmsUpdateToState(FilmsUpdated event) async* {
    yield FilmsLoaded(event.films);
  }

  @override
  Future<void> close() {
    _filmsSubscription?.cancel();
    return super.close();
  }
}