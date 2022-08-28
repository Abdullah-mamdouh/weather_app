


import 'package:flutter/cupertino.dart';
import 'astro.dart';
import 'day.dart';
import 'hour.dart';

class ForecastdayModel {

  String? date;
  // int? dateEpoch;
      DayModel? day;
  AstroModel? astro;
      List<HourModel>? hour;

  ForecastdayModel({
    this.date,
    //this.dateEpoch,
    this.day, this.astro, this.hour
  });

  factory ForecastdayModel.fromJson(Map<String, dynamic> json) {

    final List<HourModel> hourslist= [];
    json['hour'].forEach((v) {
      hourslist.add( HourModel.fromJson(v));
      //debugPrint(hourslist.toList().toString()+'aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    });
    //debugPrint("----> forecastdayModel <-----" +json.toString());
    return ForecastdayModel
      (date: json['date'], //dateEpoch: json['date_epoch'],
        day: DayModel.fromJson(json['day']),
        astro: AstroModel.fromJson(json['astro']),
        hour: hourslist,//json['hour'],
    );


  }

  Map<String, dynamic> toJson() {
    return {
    'date':date,
    //'date_epoch':dateEpoch,
    'day':day,
    'astro':astro,
    //'hour':hour!.map((v) => v.toJson()).toList(),
    };


  }
}
