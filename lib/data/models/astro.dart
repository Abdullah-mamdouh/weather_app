import 'package:flutter/cupertino.dart';

class AstroModel{

  String? sunrise;
  String? sunset;

  AstroModel({
    this.sunrise,
    this.sunset,
  });

  factory AstroModel.fromJson(Map<String, dynamic> json) {
    //debugPrint("----> AstroModel <-----" +json.toString());
    return AstroModel(
        sunrise: json['sunrise'],
        sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
