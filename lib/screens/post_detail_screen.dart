import 'package:egytour/providers/comment.dart';
import 'package:egytour/screens/login_screen.dart';

import '../providers/auth.dart';
import '../providers/comments.dart';
import '../providers/post.dart';
import 'package:flutter/material.dart';
import '../providers/place.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  static const routeName = '/post-detail';

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  var _isInit = true;
  List<Comment> _comments = [];
  late final post;
  late List<Widget> avgStars = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      post = ModalRoute.of(context)!.settings.arguments as Post;

      Provider.of<Comments>(context).getComments(post.id).then((value) {
        _comments = Provider.of<Comments>(context, listen: false).comments;
        avgStars = Provider.of<Comments>(context, listen: false)
            .getAvgStars(_comments, post.id);
        Provider.of<Auth>(context, listen: false).checkIfLoggedIn().then((_) {
          _isInit = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    var _values = {
      'stars': "-1",
      'text': '',
    };

    _submitForm() {
      if (!_form.currentState!.validate()) {
        return;
      }

      Provider.of<Comments>(context, listen: false).addComment(Comment(
          postId: post.id,
          userId: '1',
          dateTime: DateTime.now(),
          stars: int.parse(_values['stars']!),
          text: _values['text']!));
    }

    return _isInit
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 124, 152, 213),
            appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black, //change your color here
                ),
                centerTitle: true,
                title: Text(
                  post.attraction,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Lobster', fontSize: 25, color: Colors.black),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 193, 60),
                actions: avgStars),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          // child 1 of stack is the recipe image
                          ClipRRect(
                            child: Image.network(
                              post.imageUrl,
                              height: 183,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          color: const Color.fromARGB(255, 255, 193, 60),
                          width: double.infinity,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          // child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Written by ${post.email} at ${post.place.name}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-mm-dd').format(post.datetime),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          )
                          // ),
                          ),
                    ],
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 2,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      height: 500,
                      width: 400,
                      // child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Text(
                              post.title,
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              post.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        // ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 2,
                    child: Container(
                      width: 400,
                      height: 420,
                      // margin: const EdgeInsets.all(20),
                      // height: 500,
                      // child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Form(
                              key: _form,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(children: [
                                  Provider.of<Auth>(context, listen: false)
                                          .isLoggedIn
                                      ? Column(
                                          children: [
                                            DropdownButtonFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter a value.';
                                                  }

                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Rating'),
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "1",
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.star),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "2",
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "3",
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "4",
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                      ],
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "5",
                                                    child: Row(
                                                      children: const [
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  _values['stars'] =
                                                      value as String;
                                                }),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Comment',
                                              ),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textInputAction:
                                                  TextInputAction.done,
                                              maxLines: 3,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter a value.';
                                                }

                                                return null;
                                              },
                                              onChanged: (value) {
                                                _values['text'] = value;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () =>
                                                        _submitForm(),
                                                    child: const Text('post'))
                                              ],
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  LoginScreen.routeName);
                                            },
                                            child: const Text(
                                                'Log in to comment',
                                                style: TextStyle(fontSize: 30)),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: _comments.map((com) {
                                        return Row(
                                          children: [
                                            Flexible(
                                                child: Column(
                                              children: [
                                                Text(
                                                  com.text,
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  "${com.stars}/5 stars on ${DateFormat('yyyy-mm-dd').format(com.dateTime)}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Divider(
                                                  color: Colors.black54,
                                                  thickness: 1,
                                                ),
                                              ],
                                            )),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                        // ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
