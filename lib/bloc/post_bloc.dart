import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo_axon/bloc/event/post_event.dart';
import 'package:flutter_demo_axon/bloc/state/post_state.dart';
import 'package:flutter_demo_axon/data/repository/post_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({@required this.postRepository}) : super(PostInitial());

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final response = await postRepository.getPosts(query: currentState.text, page: 0);
          yield PostSuccess(
            text: currentState.text,
            posts: response.results,
            page: 0,
            hasReachedMax: false,
          );
          return;
        }
        if (currentState is PostSuccess) {
          final response = await postRepository.getPosts(query: currentState.text, page: currentState.page + 1);
          yield response.results.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
            text: currentState.text,
            posts: currentState.posts + response.results,
            page: currentState.page + 1,
            hasReachedMax: false,
          );
          return;
        }
      } catch (_) {
        yield PostFailure(text: currentState.text);
        return;
      }
    }
    if (event is SearchTextChanged) {
      if (event.text == currentState.text) {
        return;
      }
      yield PostInitial(text: event.text);
      add(PostFetched());
      return;
    }
  }

  bool _hasReachedMax(PostState state) => state is PostSuccess && state.hasReachedMax;
}
