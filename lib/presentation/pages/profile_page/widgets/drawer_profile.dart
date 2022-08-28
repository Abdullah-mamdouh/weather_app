
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/core/constant_colors/constant_colors.dart';
import 'package:untitled1/data/models/weather.dart';
import 'package:untitled1/presentation/pages/profile_page/widgets/user_info_widget.dart';

import '../../../../utils/authentication/authentication_service.dart';
import '../../location_weather_details/location_weather_details.dart';

class DrawerProile extends StatefulWidget {
  DrawerProile({Key? key, required this.locationWeather}) : super(key: key);
  WeatherModel locationWeather;
  @override
  State<DrawerProile> createState() => _DrawerProileState();
}

class _DrawerProileState extends State<DrawerProile> {

  ConstantColor constantColors = ConstantColor();

  @override
  Widget build(BuildContext context) {
    final userInfo = AuthenticationService.auth.currentUser!;
    return Drawer(
      //backgroundColor: constantColors.blackLight2,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: constantColors.fristcardColor),
            accountName: Text(
              //'${user!.name}'
                '${userInfo.displayName}'
            ),
            accountEmail: Text(
              //'${user!.email}'
                "${userInfo.email}"
            ),
            currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    backgroundImage: AssetImage("assets/image/signin_top.png")
                  //FileImage(user!.photo!),

                ),
                onTap: () {
                  /*Provider.of<ProductProvider>(context, listen: false)
                           .saveImage(pref.getString('image').toString());
                       Provider.of<ProductProvider>(context, listen: false)
                           .saveName_email(pref.getString('name').toString(),
                           pref.getString('email').toString());
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => Profile(),
                         ),
                       );*/
                }),
          ),
          //Divider(color: constantColors.lightColor,height: 15,),

          // ListTile(
          //   leading: SwitchButton(),
          //
          // ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined,),
            title: Text("Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoWidget(),
                  ),
                );
            },
          ),
          ListTile(
            leading: Image.asset('assets/image/weather_details.png',height: 30,width: 30,fit: BoxFit.cover,),
            title: Text("Weather Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationWeatherDetails(locationWeather: widget.locationWeather),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
