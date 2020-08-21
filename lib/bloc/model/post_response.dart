import 'package:equatable/equatable.dart';
import 'package:flutter_demo_axon/bloc/model/post.dart';

class PostResponse extends Equatable {
  final int total;
  final int totalPages;
  final List<Post> results;

  const PostResponse({this.total, this.totalPages, this.results});

  @override
  List<Object> get props => [total, totalPages, results];

  @override
  String toString() => 'Post { total: $total, totalPages: $totalPages, results: $results }';

  PostResponse.fromJson(Map<String, dynamic> json)
      : total = json["total"],
        totalPages = json["totalPages"],
        results = Post.fromJsonList(json["results"]);
}
