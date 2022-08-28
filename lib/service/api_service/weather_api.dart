

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../core/error/exceptions.dart';
import '../../data/models/weather.dart';
import 'package:http/http.dart' as http;


class Weather {


  Future<WeatherModel> getWeatherByLocationName(String locationName) async{
    final response = await http.get(
      Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=822d366d681d4b029f9110150221608&q=${locationName}&days=7"
        // BASE_URL + "&q=${locationName}&days=6"
      ),
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      debugPrint(decodedJson.toString());
      final weatherModel = WeatherModel.fromJson(decodedJson);
      // debugPrint(weatherModel.current!.precipMm.toString());
      return weatherModel;
    } else {
      throw ServerException();
    }
  }

}