import 'package:flutter/material.dart';
import '../static_data.dart';
import 'package:getwidget/getwidget.dart';
import '../providers/post.dart';
import '../providers/posts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screens/post_detail_screen.dart';

class PostsOverviewScreen extends StatefulWidget {
  @override
  State<PostsOverviewScreen> createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Posts>(context).fetchPosts().then((value) {
        _isInit = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<Posts>(context).posts;

    return _isInit
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: 'Categorize posts by location',
                        labelStyle: TextStyle(fontSize: 25)),
                    items: StaticData.PLACES.map((place) {
                      return DropdownMenuItem(
                        value: place['id'].toString(),
                        child: Text(place['name'] as String),
                      );
                    }).toList(),
                    onChanged: (value) {
                      Provider.of<Posts>(context, listen: false)
                          .categorizePosts(int.parse(value!));
                    }),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PostDetail.routeName,
                          arguments: posts[index]);
                    },
                    child: GFListTile(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.left,
                              posts[index].text.length >= 60
                                  ? '${posts[index].text.substring(0, 45)}...'
                                  : '${posts[index].text}...',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  posts[index].email,
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
                  ),
                ),
              ),
            ],
          );
  }
}
