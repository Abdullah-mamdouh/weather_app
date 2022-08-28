
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/core/constant_colors/constant_colors.dart';
import 'package:untitled1/presentation/pages/updated_profile_page/updated_profile_page.dart';
import 'package:untitled1/presentation/widgets/custom_button.dart';

import '../../../../utils/authentication/authentication_service.dart';
import '../../../bloc/cubit.dart';
import '../../../widgets/button.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {

  ConstantColor constantColor = ConstantColor();
  late final userInfo ;
  @override
  void initState() {
    //AppBloc.get(context).getMyLocation();
    userInfo = AuthenticationService.auth.currentUser!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userInfo = AuthenticationService.auth.currentUser!;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constantColor.fristcardColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: constantColor.fristBackgroundColor,
        /*leading: IconButton(
        onPressed: () {},
        icon: Icon(EvaIcons.settings2Outline),
      ),*/
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(
              EvaIcons.logInOutline,
              //color: constantColors.lightBlueColor,
            ),
          ),
        ],
        //backgroundColor: constantColors.blackLight2,//blueGreyColor.withOpacity(0.4),
        title: RichText(
          text: TextSpan(
            text: 'My ',
            style: TextStyle(
              //color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Profile ',
                style: TextStyle(

                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            GestureDetector(
              onTap: () {
                //storyWidget.addStory(context);
              },
              child: Container(
                height: 120,width: 110,
                      // height: MediaQuery.of(context).size.height * 0.18,
                      // width: MediaQuery.of(context).size.width * 0.28,
                      decoration: BoxDecoration(
                        //color: constantColors.transperant.withOpacity(0.5),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/person.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              '${userInfo.displayName}',
              //"ibrahim Hassan",
              style: TextStyle(
                  //color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              width: MediaQuery.of(context).size.width,
              child: Card(
                //color: Provider.of<ThemeHelper>(context).isDark ? constantColors.greyColor: Colors.teal.shade400,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide( //color: constantColors.blackLight2
                    ),
                ),
                //child: Positioned(
                  //left: 0,
                 // top: MediaQuery.of(context).size.height * 0.20,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: icon_text_edit_row(context,
                                EvaIcons.email,
                                // '${user.email}'
                                "${userInfo.email}"),
                          ),

                          SizedBox(height: 10,),

                          GestureDetector(
                            onTap: (){
                              AppBloc.get(context).getMyLocation();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: icon_text_edit_row(context,
                                  Icons.location_on_rounded,

                                   '${AppBloc.locationName}'
                                  //"Beni Suef"
                              ),
                            ),
                          ),

                          SizedBox(height: 40,),

                          CustomButton(label: 'Update Proile', color: constantColor.fristcardColor,
                              onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatedProfilePage(),));
                              }, size: size, textColor: Colors.white,
                              borderSide: BorderSide()),
                          //Button(text: 'Update Proile', onClick: () => UpdatedProfilePage()),
                        ],
                      ),
                    ),
                  ),
              //  ),
              ),
            ),

          ]
          ),
        ),
      ),
    );
  }
  icon_text_row(BuildContext context,IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //edited
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            //color: constantColors.darkColor,
              color:  Colors.blueGrey,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Icon(
            icon, //EvaIcons.email,
            color: Colors.white,
            size: 25,
          ),
        ),
        const SizedBox(width: 20,),
        Text(
          text, //'ali@gmail.com',
          style: TextStyle(
            //color: constantColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        Container(

          height: 0,
          width: 0,
        ),
      ],
    );
  }
  icon_text_edit_row(BuildContext context,IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              //color: constantColors.darkColor,
                color:  Colors.blueGrey,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Icon(
              icon, //EvaIcons.email,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Text(
              text,
              maxLines: 2,//'ali@gmail.com',
              style: TextStyle(
                //color: constantColors.greenColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 10,),
          Icon(
            EvaIcons.edit,

            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}
