import 'package:egytour/providers/place.dart';
import 'package:flutter/material.dart';
import '../static_data.dart';
import 'package:getwidget/getwidget.dart';
import './place_detail_screen.dart';

class PlacesOverviewScreen extends StatelessWidget {
  const PlacesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: StaticData.PLACES.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, PlaceDetail.routeName,
                    arguments: Place(
                        id: StaticData.PLACES[index]['id'] as int,
                        name: StaticData.PLACES[index]['name'] as String,
                        url: StaticData.PLACES[index]['url'] as String,
                        weatherName:
                            StaticData.PLACES[index]['wetherName'] as String,
                        description:
                            StaticData.PLACES[index]['description'] as String));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // child 1 of stack is the recipe image
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/${StaticData.PLACES[index]['url']}',
                            height: 183,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // child 2 of stack is the recipe title
                        Positioned.fill(
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            child: Container(
                              color: Colors.black38,
                              child: Center(
                                  child: Text(
                                StaticData.PLACES[index]['name'] as String,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
