import 'package:egytour/providers/place.dart';
import 'package:egytour/providers/post.dart';
import 'package:flutter/material.dart';
import '../static_data.dart';

class Posts with ChangeNotifier {
  var _posts = [];

  fetchPosts() {
    StaticData.POSTS.forEach((post) {
      if (_posts.any((element) {
        print(element);
        return element.id == post['id'];
      })) {
        return;
      }

      var tempPlace = StaticData.PLACES.firstWhere(
          (element) => element['id'] == int.parse(post['place'] as String));

      var tempPost = Post(
          id: post['id'] as String,
          place: Place(
              id: tempPlace['id'] as int,
              name: tempPlace['name'] as String,
              url: tempPlace['url'] as String,
              weatherName: tempPlace['wetherName'] as String,
              description: tempPlace['description'] as String),
          attraction: post['attraction'] as String,
          title: post['title'] as String,
          text: post['text'] as String,
          datetime: DateTime.parse(post['datetime'] as String),
          userId: post['userId'] as String,
          imageUrl: post['imageUrl'] as String);

      _posts.add(tempPost);
    });
  }

  get posts {
    return _posts;
  }
}
