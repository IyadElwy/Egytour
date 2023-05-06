import 'package:flutter/material.dart';
import '../providers/place.dart';

class PlaceDetail extends StatefulWidget {
  static const routeName = '/place-detail';

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  var _isInit = true;
  late var lat;
  late var lon;
  late var tempC;
  late var weatherCondition;
  late Place place;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      place = ModalRoute.of(context)!.settings.arguments as Place;
      place.getInfo().then((value) {
        lat = value['location']['lat'];
        lon = value['location']['lon'];
        tempC = value['current']['temp_c'];
        weatherCondition = value['current']['condition']['text'];

        setState(() {
          _isInit = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 152, 213),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          place.name,
          style: const TextStyle(
              fontFamily: 'Lobster', fontSize: 30, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 193, 60),
        actions: [
          // InkWell(
          //   onTap: () {},
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: const [
          //       Text(
          //         'Reviews',
          //         style: TextStyle(color: Colors.black, fontSize: 20),
          //       ),
          //       SizedBox(
          //         width: 5,
          //       ),
          //       Icon(Icons.reviews),
          //       SizedBox(
          //         width: 5,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
      body: _isInit
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          // child 1 of stack is the recipe image
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/${place.url}',
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
                          child: Column(
                            children: [
                              Text(
                                "It's curretly ${_isInit ? 'N/A' : tempC}° degrees in ${place.name}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                "Expect ${_isInit ? 'N/A' : weatherCondition} weather",
                                textAlign: TextAlign.center,
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
                    margin: EdgeInsets.all(10),
                    elevation: 2,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      height: 150,
                      // child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          place.description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // FullMap()
                ],
              ),
            ),
    );
  }
}
