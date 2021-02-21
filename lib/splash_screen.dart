import 'package:carrent/config.dart';
import 'package:carrent/screens/account/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:carrent/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:easy_localization/easy_localization.dart';


class Splash extends StatefulWidget{
  @override
  _SplashState createState()=>_SplashState();
}

class _SplashState extends State<Splash>{
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(

      seconds: 3,
      navigateAfterSeconds: new LoginScreen(),
      title: new Text(
         'welcome',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,color: primaryColor5,),
      ).tr(),
      image: new Image.asset("images/logo.jpg",
        fit: BoxFit.cover,
          color:primaryColor5,

      ),
      photoSize: 90,
      backgroundColor: Colors.white,//
      loaderColor: primaryColor5,


    );
  }
}