import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import './login_screen.dart';
import './signup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'You are not Logged in.',
            style: TextStyle(fontSize: 45),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Log in or Sign up to take full advantage of Egytour',
            style: TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 130,
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
            ],
          )
        ],
      ),
    );
  }
}
