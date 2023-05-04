import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../screens/places_overview_screen.dart';
import '../screens/posts_overview_screen.dart';
import '../screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = const [
    PlacesOverviewScreen(),
    PostsOverviewScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Egytour',
          style: TextStyle(
              fontFamily: 'Lobster', fontSize: 30, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 193, 60),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 193, 60),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        iconSize: 30,
        backgroundColor: const Color.fromARGB(255, 124, 152, 213),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.read_more),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
