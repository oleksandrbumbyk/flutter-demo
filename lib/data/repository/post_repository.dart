import 'package:flutter_demo_axon/bloc/model/post.dart';
import 'package:flutter_demo_axon/bloc/model/post_response.dart';
import 'package:flutter_demo_axon/data/remote/api_provider.dart';
import 'package:meta/meta.dart';

class PostRepository {
  final ApiProvider provider;

  PostRepository({@required this.provider}) : assert(provider != null);

  Future<PostResponse> getPosts({@required String query, @required int page}) {
    return provider.getPosts(query: query, page: page);
  }
}
