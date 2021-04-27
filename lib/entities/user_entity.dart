import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  final String email;
  final String id;
  final String? name;
  final String? photo;

  const UserEntity(this.email, this.id, this.name, this.photo,);

  Map<String, Object> toJson() {
    return {
      "email": email,
      "id": id,
      "name": name ?? '',
      "photo": photo ?? '',
    };
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json["title"] as String,
      json["imgUrl"] as String,
      json["dateTime"] as String,
      json["id"] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data()?['email'],
      snap.data()?['id'],
      snap.data()?['name'],
      snap.data()?['photo'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "email": email,
      "id": id,
      "name": name ?? '',
      "photo": photo ?? '',
    };
  }
  @override
  List<Object> get props => [email, id, name ?? '', photo ?? ''];
}