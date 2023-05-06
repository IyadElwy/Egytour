import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool isLoggedIn = false;
  String userId = '-1';
  String email = 'none';

  Future<void> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    userId = prefs.getString('userId') ?? '-1';
    email = prefs.getString('email') ?? 'none';
    notifyListeners();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    var url =
        Uri.https('egytour-58d5a-default-rtdb.firebaseio.com', '/users.json');

    try {
      final res = await http.post(url,
          body: json.encode({'email': email, 'password': password}));
      final extractedData = json.decode(res.body);

      final prefs = await SharedPreferences.getInstance();

      isLoggedIn = true;
      userId = extractedData['name'];
      email = email;

      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', extractedData['name']);
      await prefs.setString('email', email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIn(String email, String password) async {
    var url =
        Uri.https('egytour-58d5a-default-rtdb.firebaseio.com', '/users.json');

    try {
      final res = await http.get(
        url,
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      final prefs = await SharedPreferences.getInstance();

      extractedData.forEach((key, value) async {
        if (value['email'] == email && value['password'] == password) {
          this.isLoggedIn = true;
          this.userId = key;
          this.email = email;

          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userId', key);
          await prefs.setString('email', email);
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
