import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/data/models/weather.dart';
import 'package:untitled1/core/constant_colors/constant_colors.dart';

import '../../bloc/cubit.dart';
import '../../bloc/theme_bloc/cubit.dart';
import 'widget/daily_status.dart';
import 'widget/hour_status_widget.dart';
import 'widget/sunset_sunrise.dart';
import 'widget/week_status_widget.dart';

/// size of app bar when scrolling
const double _appBarCollapsedHeight = 200;

/// normal size of app bar
const double _appBarExpandedHeight = 290;

class LocationWeatherDetails extends StatefulWidget {
  LocationWeatherDetails({Key? key, required this.locationWeather})
      : super(key: key);
  WeatherModel locationWeather;
  @override
  State<LocationWeatherDetails> createState() => _LocationWeatherDetailsState();
}

class _LocationWeatherDetailsState extends State<LocationWeatherDetails> {
  final ScrollController _scrollController = ScrollController();

  double currentExtent = 0.0;

  double get minExtent => 0.0;
  double get maxExtent => _scrollController.position.maxScrollExtent;

  double get deltaExtent => maxExtent - minExtent;

  Curve get curve => Curves.easeOutCubic;

  /// initial variables
  double actionSpacing = 25;
  double titlePaddingHorizontal = 25;
  double titlePaddingTop = 170;

  /// animation when you do scroll to page
  final Tween<double> actionSpacingTween = Tween(begin: 25, end: 10);
  final Tween<double> titlePaddingHorizontalTween = Tween(begin: 25, end: 60);
  final Tween<double> titlePaddingTopTween = Tween(begin: 170, end: 60);


  //late WeatherModel weatherLocation;
  ConstantColor constantColor = ConstantColor();
  late Color backgroundColor;
  late Color cardColor;

  @override
  void initState() {
    super.initState();
    final themeColor = ThemeBloc.get(context);
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final locationInfo = widget.locationWeather.location;
    final forecastInfo = widget.locationWeather.forecast;
    final currentWeatherInfo = widget.locationWeather.current;
    // ThemeBloc.get(context);
    backgroundColor = ThemeBloc.backgroundColor;
    cardColor = ThemeBloc.cardColor;
    return BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (_, __) => [
                SliverAppBar(
                  backgroundColor: backgroundColor,
                  leading: Column(
                    children: [
                      SizedBox(height: 35,),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back_ios_outlined)),
                          SizedBox(width: actionSpacing,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: actionSpacing,
                          ),
                          Expanded(
                            child: Container(
                              width: 70,
                                child: Text(
                                  '${forecastInfo!.forecastdayModel![0].day!.avgtempC!.toInt()}',
                                  style: TextStyle(fontSize: 44, color: Colors.white),
                                  overflow: TextOverflow.fade,
                                ),
                            ),
                          ),
                          //SizedBox(width: actionSpacing,),

                          //SizedBox(width: actionSpacing,),
                        ],
                      ),

                    ],
                  ),
                  actions: [
                    Column(
                      children: [
                        SizedBox(height: 78,),
                        Row(
                          children: [
                            Lottie.asset("assets/image/sun.json", width: 90, height: 90),
                            SizedBox(width: actionSpacing,),
                          ],
                        )
                      ],
                    ),
                  ],
                  leadingWidth: 100,
                  toolbarHeight: _appBarCollapsedHeight,
                  collapsedHeight: _appBarCollapsedHeight,
                  expandedHeight: _appBarExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar.createSettings(
                    currentExtent: _appBarCollapsedHeight,
                    minExtent: _appBarCollapsedHeight,
                    maxExtent: _appBarExpandedHeight,
                    toolbarOpacity: 1.0,
                    child: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                        top: titlePaddingTop,
                        left: titlePaddingHorizontal,
                        right: titlePaddingHorizontal,
                      ),
                      //centerTitle: true,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${locationInfo!.name.toString()}',
                                style: TextStyle(fontSize: 33),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.add_location_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                '${forecastInfo.forecastdayModel![0].day!.maxtempC!.toInt()} / '
                                    '${forecastInfo.forecastdayModel![0].day!.mintempC!.toInt()} Feels like '
                                    '${forecastInfo.forecastdayModel![0].day!.avgtempC!.toInt()}',
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                '${DateFormat.E().format(DateTime.now())}, ${DateFormat.jm().format(DateTime.now())}',
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //backgroundColor: Colors.blue,
                  elevation: 8,
                  shadowColor: Colors.black45,
                  pinned: true,
                ),
              ],
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HourStatus(hours: forecastInfo!.forecastdayModel![0].hour!),
                      SizedBox(
                        height: 20,
                      ),
                      WeekStatus(weatherDay: widget.locationWeather),
                      SizedBox(
                        height: 20,
                      ),
                      SunsetAndSunrise(astroDay: forecastInfo.forecastdayModel![0].astro!),
                      SizedBox(
                        height: 20,
                      ),
                      DailyStatus(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
      }

     /// doing animation when you scroll
  _scrollListener() {
    setState(() {
      _onScroll();
      currentExtent = _scrollController.offset;

      /// change action spacing
      actionSpacing = _remapCurrentExtent(actionSpacingTween);

      /// change padding horizontal
      titlePaddingHorizontal = _remapCurrentExtent(titlePaddingHorizontalTween);

      /// change padding top
      titlePaddingTop = _remapCurrentExtent(titlePaddingTopTween);
    });
  }
  /// remap to currentExtent
  double _remapCurrentExtent(Tween<double> target) {
    final double deltaTarget = target.end! - target.begin!;

    double currentTarget =
        (((currentExtent - minExtent) * deltaTarget) / deltaExtent) +
            target.begin!;

    double t = (currentTarget - target.begin!) / deltaTarget;

    double curveT = curve.transform(t);

    return lerpDouble(target.begin!, target.end!, curveT)!;
  }

  /// change color of card and background
  void _onScroll() {

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
     ThemeBloc.get(context).changeBackgroundColor(constantColor.secondBackgroundColor);
     ThemeBloc.get(context).changeCardColor(constantColor.secondcardColor);
    }
    else if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent)
      {
        print('fffffffffffffffffffffffffffffffffffff');
        // backgroundColor = constantColor.fristBackgroundColor;
        // cardColor = constantColor.fristcardColor;
        ThemeBloc.get(context).changeBackgroundColor(constantColor.fristBackgroundColor);
        ThemeBloc.get(context).changeCardColor(constantColor.fristcardColor);
      }
    // ThemeBloc.get(context).changeBackgroundColor(backgroundColor);
    // ThemeBloc.get(context).changeCardColor(cardColor);
    // setState(() {
    //   backgroundColor = _color;
    // });
  }

  /// dispose to controllers
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
