import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const routeName = '/signup-screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();

  var _values = {
    'email': '',
    'password': '',
  };

  _submitForm() {
    if (!_form.currentState!.validate()) {
      return;
    }

    print(_values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 193, 60),
        body: Form(
            key: _form,
            child: ListView(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _values['email'] = value;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _values['password'] = value;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Passowrd'),
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GFButton(
                            color: const Color.fromARGB(255, 124, 152, 213),
                            onPressed: _submitForm,
                            size: 40,
                            child: Container(
                                width: 250,
                                child: const Text(
                                  'Submit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          GFButton(
                            color: Color.fromARGB(255, 224, 35, 25),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            size: 40,
                            child: Container(
                                width: 250,
                                child: const Text(
                                  'Back',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
