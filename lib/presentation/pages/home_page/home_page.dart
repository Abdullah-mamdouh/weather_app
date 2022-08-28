
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/presentation/pages/location_weather_details/location_weather_details.dart';
import 'package:untitled1/presentation/pages/profile_page/widgets/drawer_profile.dart';

import '../../../core/message/message_display_widget.dart';
import '../../../data/models/weather.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../location_weather_details/widget/loading_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.locationWeather})
      : super(key: key);
  WeatherModel locationWeather;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temperature = 0;
  String location = 'San Francisco';
  //int woeid = 2487956;
  String weather = 'lightcloud';
  String abbreviation = '';
  String errorMessage = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    //final address = LocationBloc.get(context);
    //final weather = AppBloc.get(context).getWeatherLocation(address.locationName!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationInfo = widget.locationWeather.location;
    final forecastInfo = widget.locationWeather.forecast;
    final currentWeatherInfo = widget.locationWeather.current;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/$weather.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            key: _scaffoldKey,
            drawer: DrawerProile(locationWeather: widget.locationWeather,),
            appBar: AppBar(
              leading: IconButton(
                onPressed:(){
                  _scaffoldKey.currentState!.openDrawer();
              },
                icon: Icon(Icons.menu,size: 35),),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      searchByCurrentLocation();
                    },
                    child: Icon(Icons.location_city, size: 36.0),
                  ),
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /* Center(
                      child: Image.network(
                        'https://www.metaweather.com/static/img/weather/png/' +
                            abbreviation +
                            '.png',
                        width: 100,
                      ),
                    ),*/
                    Center(
                      child: Text(
                        forecastInfo!.forecastdayModel![0].day!.avgtempC!.toInt().toString()+ ' °C',
                        style: TextStyle(
                            color: Colors.white, fontSize: 60.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        locationInfo!.name!,
                        style: TextStyle(
                            color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: TextField(
                        onSubmitted: (String input) {
                          searchByCountryName(input);
                          // onTextFieldSubmitted(input);
                        },
                        style:
                        TextStyle(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                          hintText: 'Search another location...',
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: 18.0),
                          prefixIcon:
                          Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 32.0, left: 32.0),
                      child: Text(errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0
                            //Platform.isAndroid ? 15.0 : 20.0
                          )),
                    )
                  ],
                ),
              ],
            ),
          )),

    );
  }

  searchByCurrentLocation(){
    AppBloc.get(context).searchAboutLocation();
    //LocationBloc.get(context).state;
    return  BlocBuilder<AppBloc, WeatherLocationState>(
        builder: (context, state)
        {
          if (state is LoadingWeatherLocationState) {
            return LoadingWidget();
          }
          else if (state is LoadedWeatherLocationState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocationWeatherDetails(locationWeather: state.weatherLocation),));;
          }
          else if (state is ErrorWeatherLocationState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        });
  }

  searchByCountryName(String locationName){
    AppBloc.get(context).getWeatherLocation(locationName);
    AppBloc.get(context).state;

    return  BlocBuilder<AppBloc, WeatherLocationState>(
        builder: (context, state) {
          if (state is LoadingWeatherLocationState) {
            return LoadingWidget();
          }
          else if (state is LoadedWeatherLocationState) {
            print('gggggggggg');
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocationWeatherDetails(locationWeather: state.weatherLocation),));
          }
          else if (state is ErrorWeatherLocationState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        });
  }

}
