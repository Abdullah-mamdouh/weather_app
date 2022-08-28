

import 'package:untitled1/data/models/location.dart';
import 'current_weather.dart';
import 'forecast.dart';

class WeatherModel{

  LocationModel? location;
  CurrentModel? current;
  ForecastModel? forecast;

  WeatherModel({
    required this.location, required this.forecast, required this.current});



  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        location: LocationModel.fromJson(json['location']),
        current: CurrentModel.fromJson(json['current']),
        forecast: ForecastModel.fromJson(json['forecast'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'current': current,
      'forecast': forecast,
    };
  }


}
