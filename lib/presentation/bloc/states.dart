

import 'package:geolocator/geolocator.dart';
import 'package:untitled1/data/models/weather.dart';

abstract class WeatherLocationState{
  const WeatherLocationState();

}

class WeatherLocationInitial extends WeatherLocationState {}

class LoadingWeatherLocationState extends WeatherLocationState {}

class LoadedWeatherLocationState extends WeatherLocationState {
  final WeatherModel weatherLocation;

  LoadedWeatherLocationState({required this.weatherLocation});
}


class GetGeoLocationPositionState extends WeatherLocationState {
  final Position position;
  GetGeoLocationPositionState({required this.position});
}

class GetAddressFromLatLongState extends WeatherLocationState {
  final String addressName;

  GetAddressFromLatLongState({required this.addressName});
}

class SavedLocationState extends WeatherLocationState {}

class GetLocationState extends WeatherLocationState {
  final String locationName;
  GetLocationState({required this.locationName});
}
class ErrorWeatherLocationState extends WeatherLocationState {
  final String message;

  ErrorWeatherLocationState({required this.message});
}