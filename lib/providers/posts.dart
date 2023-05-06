import 'package:egytour/providers/place.dart';
import 'package:egytour/providers/post.dart';
import 'package:flutter/material.dart';
import '../static_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Posts with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _postsTemp = [];

  categorizePosts(int selectedPlaceId) {
    _postsTemp =
        _posts.where((post) => post.place.id == selectedPlaceId).toList();
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _posts.clear();
    _postsTemp.clear();
    var url =
        Uri.https('egytour-58d5a-default-rtdb.firebaseio.com', '/posts.json');

    try {
      final res = await http.get(url);

      if (json.decode(res.body) == null) {
        notifyListeners();
        return;
      }

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((id, value) {
        var tempPost = Post(
            id: id,
            place: Place(
                id: value['place']['id'] as int,
                name: value['place']['name'] as String,
                url: value['place']['url'] as String,
                weatherName: value['place']['weatherName'] as String,
                description: value['place']['description'] as String),
            attraction: value['attraction'] as String,
            title: value['title'] as String,
            text: value['text'] as String,
            datetime: DateTime.parse(value['datetime'] as String),
            userId: value['userId'] as String,
            imageUrl: value['imageUrl'] as String,
            email: value['email'] as String);

        _posts.add(tempPost);
        _postsTemp.add(tempPost);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPost(Post post) async {
    var url =
        Uri.https('egytour-58d5a-default-rtdb.firebaseio.com', '/posts.json');

    try {
      final res = await http.post(url,
          body: json.encode({
            'place': {
              'id': post.place.id,
              'name': post.place.name,
              'url': post.place.url,
              'weatherName': post.place.weatherName,
              'description': post.place.description,
            },
            'attraction': post.attraction,
            'title': post.title,
            'text': post.text,
            'datetime': post.datetime.toIso8601String(),
            'userId': post.userId,
            'imageUrl':
                'https://upload.wikimedia.org/wikipedia/commons/a/af/All_Gizah_Pyramids.jpg',
            'email': post.email
          }));

      post.id = json.decode(res.body)['name'];

      _posts.add(post);
      _postsTemp.add(post);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  get posts {
    return _postsTemp;
  }
}
