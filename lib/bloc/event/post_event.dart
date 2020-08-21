import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class SearchTextChanged extends PostEvent {
  final String text;

  const SearchTextChanged({@required this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'SearchTextChanged {text: $text}';
}
