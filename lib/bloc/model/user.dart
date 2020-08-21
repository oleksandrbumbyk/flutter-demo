import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String name;

  const User({this.username, this.name});

  @override
  List<Object> get props => [username, name];

  @override
  String toString() => 'Post { username: $username, name: $name }';

  User.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        name = json["name"];
}
