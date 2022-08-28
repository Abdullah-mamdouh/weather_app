

import 'forecast_of_day.dart';

class ForecastModel {
  List<ForecastdayModel>? forecastdayModel;
  ForecastModel({this.forecastdayModel});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<ForecastdayModel> forecastlist = [];
    json['forecastday'].forEach((v) {
      forecastlist.add(new ForecastdayModel.fromJson(v));
    });

    return ForecastModel(forecastdayModel: forecastlist);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.forecastday != null) {
  //     //data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
