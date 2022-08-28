
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/data/models/weather.dart';
import 'package:untitled1/presentation/bloc/states.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failuers.dart';
import '../../core/network/network_info.dart';
import '../../core/strings/failures.dart';
import '../../service/api_service/weather_api.dart';

class AppBloc extends Cubit<WeatherLocationState> {

  AppBloc() : super(WeatherLocationInitial());
  final NetworkInfoImpl networkInfo = NetworkInfoImpl(InternetConnectionChecker());
  static SharedPreferences? sharedPreferences;
  Position? position ;
  static String? locationName ;

  /// instance
  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  /// get weather of location
  getWeatherLocation(String locationName) async{

    await fechWeatherLLocationData(locationName);
    // emit(LoadingWeatherLocationState());
    // final failureOrWeatherLocation = await Weather().getWeatherByLocationName(locationName);
    // emit(_mapFailureOrWeatherLocationToState(failureOrWeatherLocation));
  }

  /// refresh weather location
  refreshWeatherLocation(String locationName) async{
    await fechWeatherLLocationData(locationName);
  }
  //
  // WeatherLocationState _mapFailureOrWeatherLocationToState(WeatherModel either) {
  //   try{}on Exception{
  //     ErrorWeatherLocationState(
  //         message: _mapFailureToMessage(e.toString()));
  //   }
  //   return either.fold(
  //         (failure) => ErrorWeatherLocationState(
  //         message: _mapFailureToMessage(failure)),
  //         (weatherLocations) => LoadedWeatherLocationState(
  //       weatherLocation: weatherLocations,
  //     ),
  //   );
  // }

  // WeatherLocationState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
  //   return either.fold(
  //         (failure) => ErrorAddFavoriteLocationState(
  //       message: _mapFailureToMessage(failure),
  //     ),
  //         (_) => MessageAddFavoriteLocationState(message: message),
  //   );
  // }

  /// get current position
  getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    emit(GetGeoLocationPositionState(position: position!));
  }

  /// get information of location by latitude and longitude
  Future<void> getAddressFromLatLong()async {
    emit(LoadingWeatherLocationState());
    await getGeoLocationPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    locationName = place.country;
    //emit(GetAddressFromLatLongState(addressName: place.country.toString()));

  }

  /// search about any location
  searchAboutLocation() async{
    //getGeoLocationPosition();
    await getAddressFromLatLong();
    fechWeatherLLocationData(locationName!);

  }

  /// save current location
  saveLocation(String locationName) async{
    //locationName =locationName;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('my_location', locationName);
    getMyLocation();
    //emit(GetM());
  }

  /// get current location
  getMyLocation() async{
    sharedPreferences = await SharedPreferences.getInstance();
    locationName = await sharedPreferences!.getString('my_location');
    print(locationName);
    if(locationName == null){
      await getAddressFromLatLong();
      //locationName = 'cairo';
      saveLocation(locationName!);
      //emit(GetLocationState(locationName: locationName!));
    }else{
      getWeatherLocation(locationName!);
      //emit(GetLocationState(locationName: locationName!));
    }
  }

  /// call service that deal with api and get data
  fechWeatherLLocationData(String locationName) async{
    if (await networkInfo.isConnected) {
      emit(WeatherLocationInitial());
      try{
        final locationWeatherModel = await  Weather().getWeatherByLocationName(locationName);
        //Weather locationWeather = Weather(location: locationWeatherModel.location!, forecast: locationWeatherModel.forecast!, current: locationWeatherModel.current!);
        emit(LoadedWeatherLocationState(weatherLocation: locationWeatherModel));
      }on ServerException {
        emit(ErrorWeatherLocationState(message: _mapFailureToMessage(ServerFailure())));
        //return Left(ServerFailure());
      }
    }else{
      emit(ErrorWeatherLocationState(message: _mapFailureToMessage(OfflineFailure())));
      //return Left(OfflineFailure());
    }
  }

  /// map response of service with failures
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
