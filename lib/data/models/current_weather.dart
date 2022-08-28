import 'condition_weather.dart';

class CurrentModel {
  double? tempC;
  double? tempF;
  ConditionModel? condition;
  double? windKph;
  int? humidity;
  int? cloud;
  double? uv;

  CurrentModel({
    this.tempC,
    this.tempF,
    this.condition,
    this.windKph,
    this.humidity,
    this.cloud,
    this.uv,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    //debugPrint(json.toString()+"ccccccccccccccccccccccccccccccccccccccccccccccccc");
    return CurrentModel(
      //lastUpdatedEpoch : json['last_updated_epoch'],
      //lastUpdated : json['last_updated'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      //isDay : json['is_day'],
      condition: json['condition'] != null
          ? new ConditionModel.fromJson(json['condition'])
          : null,
      //windMph : json['wind_mph'],
      windKph: json['wind_kph'],
      //windDegree : json['wind_degree'],
      //windDir : json['wind_dir'],
      //pressureMb : json['pressure_mb'],
      //pressureIn : json['pressure_in'],
      // precipMm : json['precip_mm'],
      // precipIn : json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      // feelslikeC : json['feelslike_c'],
      // feelslikeF : json['feelslike_f'],
      // visKm : json['vis_km'],
      // visMiles : json['vis_miles'],
      uv: json['uv'],
      // gustMph : json['gust_mph'],
      //gustKph : json['gust_kph'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //   'last_updated_epoch': lastUpdatedEpoch,
      // 'last_updated': lastUpdated,
      'temp_c': tempC,
      'temp_f': tempF,
      // 'is_day': isDay,

      'condition': condition,
      //'wind_mph': windMph,
      'wind_kph': windKph,
      // 'wind_degree': windDegree,
      // 'wind_dir': windDir,
      // 'pressure_mb': pressureMb,
      // //'pressure_in': pressureIn,
      // 'precip_mm': precipMm,
      // 'precip_in': precipIn,
      'humidity': humidity,
      'cloud': cloud,
      // 'feelslike_c': feelslikeC,
      // 'feelslike_f': feelslikeF,
      // 'vis_km': visKm,
      // 'vis_miles': visMiles,
      'uv': uv,
      // 'gust_mph': gustMph,
      //'gust_kph': gustKph,
    };
  }
}
