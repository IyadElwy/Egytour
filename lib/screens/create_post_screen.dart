import 'dart:io';

import 'package:egytour/providers/post.dart';
import 'package:egytour/providers/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/place.dart';
import 'package:progressive_cached_network_image_cdn/image_cdn.dart';
import 'package:getwidget/getwidget.dart';
import '../static_data.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/create-post';

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _form = GlobalKey<FormState>();
  var _isInit = true;

  // ignore: prefer_final_fields
  var _values = {
    'title': '',
    'place': '',
    'attraction': '',
    'image': '',
    'text': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Auth>(context, listen: false).checkIfLoggedIn().then((value) {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<Posts>(context);

    _submitForm() {
      if (!_form.currentState!.validate()) {
        return;
      }

      var chosenPlaceMap = StaticData.PLACES
          .firstWhere((p) => p['id'] == int.parse(_values['place']!));

      postProvider.addPost(Post(
          id: DateTime.now().toString(),
          place: Place(
              id: chosenPlaceMap['id'] as int,
              name: chosenPlaceMap['name'] as String,
              url: chosenPlaceMap['url'] as String,
              weatherName: chosenPlaceMap['wetherName'] as String,
              description: chosenPlaceMap['description'] as String),
          attraction: _values['attraction'] as String,
          title: _values['title'] as String,
          text: _values['text'] as String,
          datetime: DateTime.now(),
          userId: Provider.of<Auth>(context, listen: false).userId,
          imageUrl: 'imageUrl',
          email: Provider.of<Auth>(context, listen: false).email));

      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 152, 213),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: const Text(
          'Create Post',
          style: TextStyle(
              fontFamily: 'Lobster', fontSize: 30, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 193, 60),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          _values['title'] = value;
                        },
                        decoration: const InputDecoration(labelText: 'Title'),
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
                          _values['attraction'] = value;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Attraction'),
                        textInputAction: TextInputAction.next,
                      ),
                      DropdownButtonFormField(
                          decoration: const InputDecoration(labelText: 'Place'),
                          items: StaticData.PLACES.map((place) {
                            return DropdownMenuItem(
                              value: place['id'].toString(),
                              child: Text(place['name'] as String),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _values['place'] = value as String;
                          }),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Post',
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        maxLines: 20,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a val.';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          _values['text'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GFButton(
                        color: const Color.fromARGB(255, 124, 152, 213),
                        onPressed: () {},
                        size: 30,
                        child: Container(
                            width: 250,
                            child: const Text(
                              'Choose Picture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )),
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
