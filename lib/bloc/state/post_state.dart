import 'package:equatable/equatable.dart';
import 'package:flutter_demo_axon/bloc/model/post.dart';

abstract class PostState extends Equatable {
  final String text;

  const PostState({this.text});

  @override
  List<Object> get props => [text];
}

class PostInitial extends PostState {
  const PostInitial({String text}) : super(text: text);

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'PostInitial { text: $text }';
}

class PostFailure extends PostState {
  const PostFailure({String text}) : super(text: text);

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'PostFailure { text: $text }';
}

class PostSuccess extends PostState {
  final List<Post> posts;
  final int page;
  final bool hasReachedMax;

  const PostSuccess({
    String text,
    this.posts,
    this.page,
    this.hasReachedMax,
  }) : super(text: text);

  PostSuccess copyWith({
    String text,
    List<Post> posts,
    int page,
    bool hasReachedMax,
  }) {
    return PostSuccess(
      text: text,
      posts: posts ?? this.posts,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [text, posts, page, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${posts.length}, page: $page, hasReachedMax: $hasReachedMax, text: $text }';
}
