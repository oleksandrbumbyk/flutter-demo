import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_demo_axon/bloc/model/post.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailPage extends StatefulWidget {
  Post _post;

  DetailPage(Post post) {
    _post = post;
  }

  @override
  _DetailPageState createState() => _DetailPageState(_post);
}

class _DetailPageState extends State<DetailPage> {
  Post post;

  _DetailPageState(Post post) {
    this.post = post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Hero(
                  transitionOnUserGestures: true,
                  tag: post,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: post.urls.regular,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22.0),
                Text(
                  post.description != null ? post.description : 'untitled',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Author:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        '${post.user.name}\n a.k.a ${post.user.username}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
