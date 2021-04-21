import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_bloc.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_state.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/widgets/film_item.dart';

class Explore extends StatelessWidget {

  // List<Film> films = [
  //   Film('Film 1', 'https://thumbs.dfs.ivi.ru/storage37/contents/e/3/29f42c5cd398aa4bf3f8aaaba136e6.jpg', "2019-04-24", '1', '5'),
  //   Film('Film 2', 'https://thumbs.dfs.ivi.ru/storage37/contents/e/3/29f42c5cd398aa4bf3f8aaaba136e6.jpg', "2019-04-24", '2', '4'),
  //   Film('Film 3', 'https://thumbs.dfs.ivi.ru/storage37/contents/e/3/29f42c5cd398aa4bf3f8aaaba136e6.jpg', "2019-04-24", '3', '6'),
  //   Film('Film 4', 'https://thumbs.dfs.ivi.ru/storage37/contents/e/3/29f42c5cd398aa4bf3f8aaaba136e6.jpg', "2019-04-24", '4', '7'),
  //   Film('Film 5', 'https://thumbs.dfs.ivi.ru/storage37/contents/e/3/29f42c5cd398aa4bf3f8aaaba136e6.jpg', "2019-04-24", '5', '9'),
  // ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 100) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список фильмов'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocBuilder<FilmsApiBloc, FilmsApiState>(
          builder: (context, state) {
            if (state is FilmsApiLoads) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FilmsApiLoadSuccess) {
              final films = state.apiFilms;
              return GridView.builder(
                  itemCount: films.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: (itemWidth / itemHeight)),
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return FilmItem(film: film, tap: true,);
                  });
            } else return Center(child: Text('Somwhere went wrong'));
          },
          // child:
        ),
      ),
    );
  }
}
