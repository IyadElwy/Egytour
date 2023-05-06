import './comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class Comments with ChangeNotifier {
  List<Comment> _comments = [];
  List<Comment> _commentsTemp = [];

  Future<void> getComments(String postId) async {
    _comments.clear();
    _commentsTemp.clear();
    var url = Uri.https(
        'egytour-58d5a-default-rtdb.firebaseio.com', '/comments.json');

    try {
      final res = await http.get(url);

      if (json.decode(res.body) == null) {
        return;
      }
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((id, value) {
        _comments.add(Comment(
            postId: value['postId'],
            userId: value['userId'],
            dateTime: DateTime.parse(value['datetime']),
            stars: value['stars'],
            text: value['text']));
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }

    _commentsTemp =
        _comments.where((comment) => comment.postId == postId).toList();
  }

  get comments {
    return _commentsTemp;
  }

  Future<void> addComment(Comment comment) async {
    var url = Uri.https(
        'egytour-58d5a-default-rtdb.firebaseio.com', '/comments.json');

    try {
      final res = await http.post(url,
          body: json.encode({
            'postId': comment.postId,
            'userId': comment.userId,
            'datetime': comment.dateTime.toIso8601String(),
            'stars': comment.stars,
            'text': comment.text
          }));
      _comments.add(comment);
      _commentsTemp.add(comment);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  getAvgStars(List<Comment> theComments, String postId) {
    var comments = 0;
    var stars = 0;

    List<Widget> starIcons = [
      const SizedBox(
        width: 5,
      )
    ];

    theComments.forEach((com) {
      if (com.postId == postId) {
        comments++;
        stars += com.stars;
      }
    });

    if (comments <= 0) {
      return starIcons;
    }

    var avg = (stars ~/ comments).toInt();

    if (avg > 5) {
      avg = 5;
    }

    for (var i = 0; i < avg; i++) {
      starIcons.insert(
        0,
        const Icon(Icons.star),
      );
    }
    notifyListeners();

    return starIcons;
  }
}
