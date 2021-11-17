import 'dart:convert';

import 'package:custom/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class WeatherReport extends StatefulWidget {
  @override
  _WeatherReportState createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  final l = Logger();
  int mainTemperature = 0;
  int mainHighTemperature = 0;
  int mainLowTemperature = 0;
  String mainWeather = '';
  String selectedCountry = '';
  String mainDescription = '';
  var currentTime =
      int.parse((DateTime.now().toString().substring(11, 13)).toString());
  int mainHumidity = 0;
  var forGettingTime;
  List gettingResponseDaily = [];

  int ints = 0;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    double fontSize = height * 0.01;

    return Theme(
      data: currentTime >= 18 && currentTime <= 24
          ? Themes.darkTheme
          : currentTime < 6
              ? Themes.darkTheme
              : Themes.lightTheme,
      child: Scaffold(
        body: gettingResponseDaily == null
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(left: width * 0.05),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.yellow.shade400,
                    width: (height) * 0.003,
                  ))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: ((height) * 0.08),
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              selectedCountry,
                              style: TextStyle(
                                  fontSize: fontSize * 4,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: ((height) * 0.08),
                            width: width * 0.15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                hello();
                              },
                              child: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: fontSize * 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ((height) * 0.02),
                      ),
                      Row(
                        children: [
                          Container(
                            height: ((height)) * 0.008,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            height: ((height)) * 0.008 / 4,
                            width: width * 0.5,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ((height) * 0.04),
                      ),
                      Row(
                        children: [
                          Text(
                            'H $mainHighTemperature ° ',
                            style: TextStyle(
                                fontSize: fontSize * 2,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '/ L $mainLowTemperature °',
                            style: TextStyle(
                                fontSize: fontSize * 2,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ((height) * 0.06),
                      ),
                      SizedBox(
                        height: ((height) * 0.45),
                        width: width - (width * 0.05),
                        child: Row(
                          children: [
                            SizedBox(
                              width: (width - (width * 0.05)) * 0.58,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          '$mainTemperature',
                                          style: TextStyle(
                                              fontSize: fontSize * 10,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: height * 0.04),
                                          child: Text(
                                            '°',
                                            style: TextStyle(
                                                fontSize: fontSize * 5,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ((height)) * 0.6 * 0.005,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(mainWeather,
                                          style: TextStyle(
                                              fontSize: fontSize * 2.5,
                                              fontWeight: FontWeight.w600))),
                                  SizedBox(
                                    height: ((height)) * 0.6 * 0.12,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.umbrella,
                                        size: fontSize * 3,
                                      ),
                                      Text(
                                        '$mainHumidity%',
                                        style: TextStyle(
                                            fontSize: fontSize * 2.5,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ((height)) * 0.6 * 0.12,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mainDescription,
                                      style: TextStyle(
                                          fontSize: fontSize * 2,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipPath(
                              clipper: Semi(),
                              child: Container(
                                color: Colors.yellow.shade400,
                                width: (width - (width * 0.05)) * 0.42,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ((height) * 0.08),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ...gettingResponseDaily.map(
                                  (e) {
                                    return Container(
                                      height: ((height) * 0.03),
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white, width: 2)),
                                      ),
                                      child: Text(
                                        "  ${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch((e['dt'] * 1000.0).round())).toString().substring(0, 3)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSize * 2),
                                      ),
                                    );
                                  },
                                ).toList()
                              ],
                            ),
                            Row(
                              children: [
                                ...gettingResponseDaily.map(
                                  (e) {
                                    return Container(
                                      height: ((height) * 0.10),
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: ((height) * 0.10),
                                            width: width * 0.1,
                                            child: Image.network(
                                              'https://openweathermap.org/img/w/${e['weather'][0]['icon']}.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${e['temp']['day'].round()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: fontSize * 2.5),
                                              ),
                                              Text("c"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList()
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    if (ints == countries.length) {
      ints = 0;
    }
    String gotCountry = (countries[ints]);
    selectedCountry = countries[ints];
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$gotCountry&appid=3a11fbea4c16409c7d0f15d7b81ac0c7&units=metric'));
    var gettingFirstResponse = json.decode(response.body);
    var response1 = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${gettingFirstResponse['coord']['lat']}&lon=${gettingFirstResponse['coord']['lon']}&exclude=minutely,hourly,alerts&appid=3a11fbea4c16409c7d0f15d7b81ac0c7&units=metric'));
    forGettingTime = DateTime.fromMillisecondsSinceEpoch(
        (gettingFirstResponse['dt'] * 1000.0).round());
    // l.e(forGettingTime);
    var gettingResponse = (json.decode(response1.body));
    l.e(gettingResponse);
    setState(() {
      currentTime =
          int.parse((DateTime.now().toString().substring(11, 13)).toString());
      gettingResponseDaily = gettingResponse['daily'];
      selectedCountry = countries[ints];
      mainTemperature =
          ((gettingResponse['current']['temp'].round() * 9 / 5) + 32).round();
      mainWeather = gettingResponse['current']['weather'][0]['main'];
      mainDescription = gettingResponse['current']['weather'][0]['description'];
      mainHumidity = gettingResponse['current']['humidity'].round();
      mainHighTemperature =
          ((gettingResponse['daily'][0]['temp']['max'].round() * 9 / 5) + 32)
              .round();
      mainLowTemperature =
          ((gettingResponse['daily'][0]['temp']['min'].round() * 9 / 5) + 32)
              .round();
    });
    ints++;
  }
}
