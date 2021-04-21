import 'package:intl/intl.dart';
import 'package:login_firebase/entities/film_entity.dart';
import 'package:meta/meta.dart';

class Film {

  final String title;
  final String imgUrl;
  final String dateTime;
  final String id;
  final String raiting;
  // final bool added;

  Film(this.title, this.imgUrl, this.dateTime, this.id, this.raiting);

  FilmEntity toEntity() {
    return FilmEntity(title, imgUrl, dateTime, id, raiting);
  }

  static Film fromJson(dynamic json) {
    return Film(
        json['title'] as String,
        json['poster_path'] == null ? '' : json['poster_path'] as String,
        stringToDate(json['release_date'] as String),
        // json['release_date'] as String,
        json['id'].toString(),
        json['popularity'].toString().substring(0, 5));
  }

  static Film fromEntity(FilmEntity entity) {
    return Film(
        entity.title,
        entity.imgUrl,
        entity.dateTime,
        entity.id,
        entity.raiting.substring(0, 5)
        );
  }

  static String stringToDate(String date) {
    var dateTime = DateTime.parse(date);
    var formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  int get hashCode =>
      title.hashCode ^ imgUrl.hashCode ^ dateTime.hashCode ^ id.hashCode;
}