import 'package:flutter/material.dart';
import '../static_data.dart';
import 'package:getwidget/getwidget.dart';
import '../providers/post.dart';
import '../providers/posts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostsOverviewScreen extends StatefulWidget {
  const PostsOverviewScreen({super.key});

  @override
  State<PostsOverviewScreen> createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Posts>(context).fetchPosts();
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<Posts>(context).posts;

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => GFListTile(
        color: Colors.white,
        avatar: Container(
          width: 40,
          child: Image.network(
            posts[index].imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          posts[index].title,
          style: const TextStyle(fontSize: 24),
        ),
        subTitle: Container(
          height: 70,
          child: Column(
            children: [
              Text(
                '${posts[index].text.substring(0, 60)}...',
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    posts[index].userId,
                  ),
                  Text(
                    DateFormat('yyyy-mm-dd')
                        .format(posts[index].datetime)
                        .toString(),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
