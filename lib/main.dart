import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_axon/bloc/bloc_observer.dart';
import 'package:flutter_demo_axon/bloc/event/post_event.dart';
import 'package:flutter_demo_axon/bloc/post_bloc.dart';
import 'package:flutter_demo_axon/data/repository/post_repository.dart';
import 'package:flutter_demo_axon/data/remote/api_provider.dart';
import 'package:flutter_demo_axon/presentation/home_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final postRepository = PostRepository(provider: ApiProvider());
  runApp(BlocProvider<PostBloc>(
    create: (context) => PostBloc(postRepository: postRepository)..add(PostFetched()),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: HomePage(),
      ),
    );
  }
}
