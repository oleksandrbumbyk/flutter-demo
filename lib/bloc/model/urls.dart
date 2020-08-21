import 'package:equatable/equatable.dart';

class Urls extends Equatable {
  final String full;
  final String regular;

  const Urls({this.full, this.regular});

  @override
  List<Object> get props => [full, regular];

  @override
  String toString() => 'Post { full: $full, regular: $regular }';

  Urls.fromJson(Map<String, dynamic> json)
      : full = json["full"],
        regular = json["regular"];
}
