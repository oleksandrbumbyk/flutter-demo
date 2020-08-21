import 'package:equatable/equatable.dart';
import 'package:flutter_demo_axon/bloc/model/urls.dart';
import 'package:flutter_demo_axon/bloc/model/user.dart';

class Post extends Equatable {
  final String id;
  final Urls urls;
  final User user;
  final String description;

  const Post({this.id, this.urls, this.user, this.description});

  @override
  List<Object> get props => [id, urls, user, description];

  @override
  String toString() => 'Post { id: $id, urls: $urls, user: $user, description: $description }';

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        urls = Urls.fromJson(json["urls"]),
        user = User.fromJson(json["user"]),
        description = json["description"];

  static List<Post> fromJsonList(List<dynamic> json) {
    return json.map((e) => Post.fromJson(e)).toList();
  }
}
