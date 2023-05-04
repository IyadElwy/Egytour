import '../screens/signup_screen.dart';

import '../screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 193, 60),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 124, 152, 213),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(25),
                  child: const Text(
                    'Egytour',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Lobster',
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'assets/images/pyramids.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GFButton(
                color: const Color.fromARGB(255, 124, 152, 213),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                size: 80,
                child: Container(
                    width: 250,
                    child: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              GFButton(
                color: const Color.fromARGB(255, 124, 152, 213),
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                size: 80,
                child: Container(
                    width: 250,
                    child: const Text(
                      'Sign-Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              GFButton(
                color: const Color.fromARGB(255, 124, 152, 213),
                onPressed: () {},
                size: 80,
                child: Container(
                    width: 250,
                    child: const Text(
                      'Continue as guest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
