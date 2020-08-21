import 'package:flutter/material.dart';
import 'package:flutter_demo_axon/bloc/model/post.dart';
import 'package:flutter_demo_axon/presentation/detail_page.dart';
import 'package:transparent_image/transparent_image.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Hero(
          tag: post,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: post.urls.regular, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
