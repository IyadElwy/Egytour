import 'package:flutter/material.dart';
import './place.dart';

class Post with ChangeNotifier {
  String id;
  Place place;
  String attraction;
  String title;
  String text;
  DateTime datetime;
  String userId;
  String imageUrl;

  Post(
      {required this.id,
      required this.place,
      required this.attraction,
      required this.title,
      required this.text,
      required this.datetime,
      required this.userId,
      required this.imageUrl});
}
