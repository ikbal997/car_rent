import 'package:carrent/config.dart';
import 'package:carrent/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CongratulationsScreen extends StatefulWidget {
  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0.0,
          title: Text(
            "",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ).tr(),
          centerTitle: true,
        ),
//        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
//              color: primaryColor5.withOpacity(0.7),
            gradient: LinearGradient(
                colors: [primaryColor5, primaryColor6],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 80)),
                Icon(
                  Icons.check,
                  size: 70,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                  child: Text(
                    "congratulations",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  ).tr(),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "back",
                        style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ).tr(),
                      Icon(Icons.arrow_forward,size: 24,color: Colors.white,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
