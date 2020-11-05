import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_flutter/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    print('this code is triggered');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
  }

  void getData() async{
    http.Response response = await http.get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);

      double temperature = decodeData['main']['temp'];
      String cityName = decodeData['name'];
      int weatherCondition = decodeData['weather'][0]['id'];
      print(temperature);
      print(cityName);
      print(weatherCondition);

    }else {
      print(response.statusCode);
    }

  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
