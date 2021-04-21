import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FilmEntity extends Equatable {
  final String title;
  final String imgUrl;
  final String dateTime;
  final String id;
  final String raiting;
  // final bool added;

  const FilmEntity(this.title, this.imgUrl, this.dateTime, this.id, this.raiting);

  Map<String, Object> toJson() {
    return {
      "title": title,
      "imgUrl": imgUrl,
      "dateTime": dateTime,
      "id": id,
      "raiting": raiting,
      // "added": added
    };
  }

  static FilmEntity fromJson(Map<String, Object> json) {
    return FilmEntity(
      json["title"] as String,
      json["imgUrl"] as String,
      json["dateTime"] as String,
      json["id"] as String,
      json["raiting"] as String,
      // json["added"] as bool
    );
  }

  static FilmEntity fromSnapshot(DocumentSnapshot snap) {
    return FilmEntity(
        snap.data()?['title'],
        snap.data()?['imgUrl'],
        snap.data()?['dateTime'],
        // (snap.data()?['dateTime'] as Timestamp).toDate(),
        snap.data()?['id'],
        snap.data()?['raiting'],
        // snap.data()?['added']
    );
  }

  Map<String, Object> toDocument() {
    return {
      "title": title,
      "imgUrl": imgUrl,
      "dateTime": dateTime,
      "id": id,
      "raiting": raiting,
      // "added": added
    };
  }
  @override
  List<Object> get props => [title, imgUrl, dateTime];
}