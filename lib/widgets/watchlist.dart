import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/logic/blocs/film/films.dart';

import 'film_item.dart';

class Watchlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 100) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавленные фильмы'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocBuilder<FilmsBloc, FilmsState>(
          builder: (context, state) {
            if (state is FilmsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FilmsLoaded) {
              final films = state.films;
              print(films);
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: (itemWidth / itemHeight)
                  ),
                  itemCount: state.films.length,
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return FilmItem(film: film, tap: true,);
                  });
            } else return TextButton(
                onPressed: () {
                  BlocProvider.of<FilmsBloc>(context).add(
                    LoadFilms(),
                  );
                },
                child: Text('load'));
          },
        ),
      ),
    );
  }
}
