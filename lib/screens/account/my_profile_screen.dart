import 'package:carrent/drawer/drawer.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/account/edit_profile_screen.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {


  bool serverError = false, connectedToNetwork = true;
  Future<UserProfile> model;

  @override
  void initState() {
    super.initState();
    initialize();
  }

//
  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          model = AppRequests.fetchProfile().catchError((error, stackTrace)
          {
            setState(() {
              print("error server");
              serverError = true;
            });
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(""),
      ),
      drawer: AppDrawer(),
//      resizeToAvoidBottomInset: false,
//      backgroundColor: primaryColor3,
      extendBodyBehindAppBar: true,
      body:
      Builder(builder: (context) {
        if (connectedToNetwork == false) {
          return NoInternetConnection(voidCallback: initialize);
        } else {
          if (serverError) {
            return ServerError(voidCallback: initialize);
          } else {
            return FutureBuilder<UserProfile>(
              future: model,
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  return
                    Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/background.png"),
                            fit: BoxFit.cover)),
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.only(top: 30, left: 10, right:10),
//                          color: primaryColor3,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                color: primaryColor5,
                                size: 50,
                              ),
                            ),
                          ),
//                              Card(
//                                child:
                          Container(
//                                  height:MediaQuery.of(context).size.height/3 ,
//                                  decoration: BoxDecoration(
//                                    color: primaryColor3,
//                                    borderRadius: BorderRadius.circular(10),
//
//
//                                  ),
                            child: Center(
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 10,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        snapshot.data.firstname +"  "+
                                            snapshot.data.lastname,
//                              results[0]['firstname'] ,
//                                  "  " +
//                                  results[0]['lastname'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor5),
                                      ),
                                    ),
                                    Divider(
                                      color: primaryColor5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 30,
                                          left: 40,
                                          right: 20,
                                          bottom: 30),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: primaryColor5,
                                            size: 30,
                                          ),
//
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20)),
                                          Text(
                                            snapshot.data.phoneNumber.toString(),
//                                  results[0]["phoneNumber"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
//                                      Divider(color: primaryColor,),
//                                      InkWell(
//                                        onTap: () {},

                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 20,bottom: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: primaryColor5,
                                            size: 30,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20)),
                                          Text(
                                            snapshot.data.email,
//                                  results[0]['email'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),

                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileScreen(snapshot.data)),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
//                        padding: EdgeInsets.only(left: 30),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: primaryColor5,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "editprofile",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ).tr(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
//                              )
                        ],
                      ),
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
        }
      }
      ),
    );
  }
}
