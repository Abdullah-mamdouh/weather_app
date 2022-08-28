import 'package:flutter/cupertino.dart';

import 'condition_weather.dart';

class HourModel {
  String? time;
  double? tempC;
  double? tempF;
  ConditionModel? condition;
  int? humidity;
  int? cloud;

  HourModel({
    this.time,
    this.tempC,
    this.tempF,
    this.condition,
    this.humidity,
    this.cloud,
  });

  factory HourModel.fromJson(Map<String, dynamic> json) {
    //debugPrint("----> hourModel <-----" +json.toString());
    return HourModel(
        //timeEpoch: json['time_epoch'],
        time: json['time'],
        tempC: json['temp_c'],
        tempF: json['temp_f'],
        //isDay: json['is_day'],
        condition: ConditionModel.fromJson(json['condition']),
        // windMph: json['wind_mph'],
        // windKph: json['wind_kph'],
        //windDegree: json['wind_degree'],
        // windDir: json['wind_dir'],
        // //pressureMb: json['pressure_mb'],
        // pressureIn: json['pressure_in'],
        // precipMm: json['precip_mm'],
        // precipIn: json['precip_in'],
        humidity: json['humidity'],
        cloud: json['cloud'],
        // feelslikeC: json['feelslike_c'],
        // feelslikeF: json['feelslike_f'],
        // windchillC: json['windchill_c'],
        // windchillF: json['windchill_f'],
        // heatindexC: json['heatindex_c'],
        // heatindexF: json['heatindex_f'],
        // dewpointC: json['dewpoint_c'],
        // dewpointF: json['dewpoint_f'],
        //willItRain: json['will_it_rain'],
        //chanceOfRain: json['chance_of_rain'],
        // willItSnow: json['will_it_snow'],
        // chanceOfSnow: json['chance_of_snow'],
        // visKm: json['vis_km'],
        // visMiles: json['vis_miles'],
        // gustMph: json['gust_mph'],
        // gustKph: json['gust_kph'],
        //uv: json['uv']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'time_epoch': timeEpoch,
      'time': time,
      'temp_c': tempC,
      'temp_f': tempF,
      // 'is_day': isDay,
      'condition': condition,
      // 'wind_mph': windMph,
      // 'wind_kph': windKph,
      // 'wind_degree': windDegree,
      // 'wind_dir': windDir,
      // 'pressure_mb': pressureMb,
      // 'pressure_in': pressureIn,
      // 'precip_mm': precipMm,
      // 'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      // 'feelslike_c': feelslikeC,
      // 'feelslike_f': feelslikeF,
      // 'windchill_c': windchillC,
      // 'windchill_f': windchillF,
      // 'heatindex_c': heatindexC,
      // 'heatindex_f': heatindexF,
      // 'dewpoint_c': dewpointC,
      // 'dewpoint_f': dewpointF,
      // 'will_it_rain': willItRain,
      // 'chance_of_rain': chanceOfRain,
      // 'will_it_snow': willItSnow,
      // 'chance_of_snow': chanceOfSnow,
      // 'vis_km': visKm,
      // 'vis_miles': visMiles,
      // 'gust_mph': gustMph,
      // 'gust_kph': gustKph,
      // 'uv': uv,
    };
  }
}
