import 'package:flutter/material.dart';
import './post.dart';

class Comment with ChangeNotifier {
  String postId;
  String userId;
  DateTime dateTime;
  int stars;
  String text;

  Comment(
      {required this.postId,
      required this.userId,
      required this.dateTime,
      required this.stars,
      required this.text});
}
