import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Place with ChangeNotifier {
  int id;
  String name;
  String url;
  String weatherName;
  String description;

  Place(
      {required this.id,
      required this.name,
      required this.url,
      required this.weatherName,
      required this.description});

  Future<Map> getInfo() async {
    var url = Uri.https('api.weatherapi.com', '/v1/current.json', {
      'key': '0d2ec6a3b01842e99f0121543230405',
      'q': weatherName,
      'aqi': 'no'
    });

    var result;
    try {
      result = await http.get(
        url,
      );
    } catch (e) {
      rethrow;
    }
    return json.decode(result.body);
  }
}
