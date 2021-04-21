import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_firebase/constants.dart';
import 'package:login_firebase/models/film.dart';
import 'package:login_firebase/screens/film_details.dart';

class FilmItem extends StatelessWidget {

  final Film film;
  final bool tap;
  // String img = '';

  const FilmItem({Key? key, required this.film, required this.tap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var dateTime = DateTime.parse(film.dateTime);
    // var formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);

    return GestureDetector(
      onTap: tap ? (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FilmDetails(film);
        }));
      } : (){},

      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(imgBaseUrl + film.imgUrl, fit: BoxFit.fitWidth,),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Text(film.title)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('raiting ${film.raiting}'),
              Text('${film.dateTime}')
              // Text('$formattedDate')
            ],
          )
        ],
      ),
    );
  }
}
