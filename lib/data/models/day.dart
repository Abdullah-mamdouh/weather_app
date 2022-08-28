import 'package:flutter/cupertino.dart';
import 'condition_weather.dart';

class DayModel {
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindMph;
  double? maxwindKph;
  ConditionModel? condition;
  int? uv;

  DayModel({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.condition,
    this.uv,
    //  int? uv,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    //debugPrint("----> DayModel <-----" + json.toString());
    return DayModel(
      maxtempC: json['maxtemp_c'],
      maxtempF: json['maxtemp_f'],
      mintempC: json['mintemp_c'],
      mintempF: json['mintemp_f'],
      avgtempC: json['avgtemp_c'],
      avgtempF: json['avgtemp_f'],
      maxwindMph: json['maxwind_mph'],
      maxwindKph: json['maxwind_kph'],
      // totalprecipMm : json['totalprecip_mm'],
      // totalprecipIn : json['totalprecip_in'],
      // avgvisKm : json['avgvis_km'],
      // avgvisMiles : json['avgvis_miles'],
      // avghumidity : json['avghumidity'],
      // dailyWillItRain : json['daily_will_it_rain'],
      // dailyChanceOfRain : json['daily_chance_of_rain'],
      // dailyWillItSnow : json['daily_will_it_snow'],
      // dailyChanceOfSnow : json['daily_chance_of_snow'],
      condition: json['condition'] != null
          ? new ConditionModel.fromJson(json['condition'])
          : null,
      //uv : json['uv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxtemp_c': maxtempC,
      'maxtemp_f': maxtempF,
      'mintemp_c': mintempC,
      'mintemp_f': mintempF,
      'avgtemp_c': avgtempC,
      'avgtemp_f': avgtempF,
      'maxwind_mph': maxwindMph,
      'maxwind_kph': maxwindKph,
      // 'totalprecip_mm': totalprecipMm,
      // 'totalprecip_in': totalprecipIn,
      // 'avgvis_km': avgvisKm,
      // 'avgvis_miles': avgvisMiles,
      // 'avghumidity': avghumidity,
      // 'daily_will_it_rain': dailyWillItRain,
      // 'daily_chance_of_rain': dailyChanceOfRain,
      // 'daily_will_it_snow': dailyWillItSnow,
      // 'daily_chance_of_snow': dailyChanceOfSnow,

      'condition': condition,

      'uv': uv,
    };
  }
}
