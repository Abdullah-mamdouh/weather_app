

import 'package:flutter/cupertino.dart';

class LocationModel {

  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  //int? localtimeEpoch;
  String? localtime;

  LocationModel({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    //this.localtimeEpoch,
    this.localtime
}) ;



  factory LocationModel.fromJson(Map<String, dynamic> json) {
    //debugPrint(json.toString()+"lllllllllllllllllllllllllllllllllllllllllllllllll");
   return LocationModel(
       name: json['name'],
       region : json['region'],
    country : json['country'],
    lat : json['lat'],
    lon : json['lon'],
    tzId : json['tz_id'],
    // localtimeEpoch : json['localtime_epoch'],
    localtime : json['localtime'],
   );
  }

  Map<String, dynamic> toJson() {
    return {
    'name':name,
    'region':region,
    'country':country,
    'lat':lat,
    'lon':lon,
    'tz_id':tzId,
    // 'localtime_epoch':localtimeEpoch,
    'localtime':localtime,
    };

  }
}
