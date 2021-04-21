import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:login_firebase/constants.dart';
import 'package:login_firebase/logic/blocs/film/films.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/theme.dart';

class FilmDetails extends StatelessWidget {

  final Film _film;
  FilmDetails(this._film);

  bool checkButton(List<Film> films) {
    for (int i = 0; i < films.length; i++) {
      if (films[i].id == _film.id)
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(_film.dateTime);
    var formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FilmsBloc, FilmsState>(
        builder: (context, state) {
          if (state is FilmsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network(imgBaseUrl + _film.imgUrl,
                          height: 210,),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          height: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Text(_film.title),
                                  Expanded(child: Text('${formattedDate}')),
                                  // Text('$formattedDate'),
                                  Text('raiting ${_film.raiting}'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          primary: checkButton(state.films) ? theme.disabledColor : theme.accentColor,
                        ),
                        onPressed: checkButton(state.films) ? () {} : () {
                          BlocProvider.of<FilmsBloc>(context).add(AddFilm(_film));
                          print('Added');
                        },
                        child: Text('Add to Watchlist',
                          style: TextStyle(
                              color: Colors.white
                          ),)),
                  ),
                  SizedBox(height: 20,),
                  Text('Primari info'),
                  SizedBox(height: 25,),
                  Text('Trailers'),
                  SizedBox(height: 25,),
                  Text('Cast'),
                  SizedBox(height: 25,),
                  Text('Crew'),
                  SizedBox(height: 25,),
                  Text('Plot keywords'),
                ],
              ),
            );
          } else return Container();
        },
      ),
    );
  }
}

