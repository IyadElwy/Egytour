import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///////////////////////////////////////////////

import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart';
import './screens/place_detail_screen.dart';

///////////////////////////////////////////////

import './providers/posts.dart';

///////////////////////////////////////////////

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctz) => Posts())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Egytour',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(fontFamily: 'PTSans')),
        ),
        home: const WelcomeScreen(),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          SignupScreen.routeName: (context) => const SignupScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          PlaceDetail.routeName: (context) => PlaceDetail(),
        },
      ),
    );
  }
}
