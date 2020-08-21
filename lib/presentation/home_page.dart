import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_axon/bloc/event/post_event.dart';
import 'package:flutter_demo_axon/bloc/post_bloc.dart';
import 'package:flutter_demo_axon/bloc/state/post_state.dart';
import 'package:flutter_demo_axon/presentation/common/bottom_loader.dart';
import 'package:flutter_demo_axon/presentation/common/post_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _searchController = TextEditingController();

  final _scrollController = ScrollController();

  final _scrollThreshold = 200.0;

  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChange);
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Form(
            child: TextFormField(
              autofocus: false,
              controller: _searchController,
              cursorColor: Theme.of(context).primaryColor,
              obscureText: false,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2.0),
                labelText: 'Search',
                labelStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: 18.0),
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is PostFailure) {
              return Expanded(
                child: Center(
                  child: Text('Failed to fetch posts', style: TextStyle(fontSize: 18.0)),
                ),
              );
            }
            if (state is PostSuccess) {
              if (state.posts.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text('No posts', style: TextStyle(fontSize: 18.0)),
                  ),
                );
              }
              return Expanded(
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                  index >= state.posts.length ? BottomLoader() : PostWidget(post: state.posts[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              );
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostFetched());
    }
  }

  void _onSearchTextChange() {
    BlocProvider.of<PostBloc>(context).add(
      SearchTextChanged(text: _searchController.text),
    );
  }
}
