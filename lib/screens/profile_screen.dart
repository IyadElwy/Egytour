import 'package:egytour/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import './login_screen.dart';
import './signup_screen.dart';
import '../providers/auth.dart';
import './create_post_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Auth>(context, listen: false).checkIfLoggedIn().then((value) {
        setState(() {
          _isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInit == true) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 193, 60),
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (_isInit == false &&
        Provider.of<Auth>(context, listen: false).isLoggedIn) {
      return const LoggedIn();
    } else {
      return const NotLoggedIn();
    }
  }
}

class LoggedIn extends StatelessWidget {
  const LoggedIn({super.key});

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
            'Hello, User!',
            style: TextStyle(fontSize: 45),
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
                  Navigator.pushNamed(context, CreatePostScreen.routeName);
                },
                size: 80,
                child: Container(
                    width: 250,
                    child: const Text(
                      'Create New Post',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GFButton(
                color: Color.fromARGB(255, 209, 5, 5),
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logOut().then((_) {
                    Navigator.pushReplacementNamed(
                        context, WelcomeScreen.routeName);
                  });
                },
                size: 80,
                child: Container(
                    width: 250,
                    child: const Text(
                      'Log out',
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

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({
    super.key,
  });

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
