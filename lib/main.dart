import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/comment.dart';
import './providers/comments.dart';
import './providers/posts.dart';

///////////////////////////////////////////////

import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart';
import './screens/place_detail_screen.dart';
import './screens/create_post_screen.dart';
import './screens/post_detail_screen.dart';

///////////////////////////////////////////////

import './providers/posts.dart';
import './providers/auth.dart';

///////////////////////////////////////////////

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctz) => Posts()),
        ChangeNotifierProvider(create: (ctz) => Comments()),
        ChangeNotifierProvider(create: (ctz) => Auth()),
      ],
      child: const TheApp(),
    );
  }
}

class TheApp extends StatefulWidget {
  const TheApp({
    super.key,
  });

  @override
  State<TheApp> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Auth>(context).checkIfLoggedIn().then((value) {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Egytour',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(fontFamily: 'PTSans')),
        ),
        home: _isInit == false
            ? (Provider.of<Auth>(context).isLoggedIn
                ? const HomeScreen()
                : const WelcomeScreen())
            : const Center(
                child: CircularProgressIndicator(),
              ),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          PlaceDetail.routeName: (context) => PlaceDetail(),
          CreatePostScreen.routeName: (context) => CreatePostScreen(),
          PostDetail.routeName: (context) => PostDetail(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}
