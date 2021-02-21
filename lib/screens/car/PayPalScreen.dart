import 'dart:convert';

import 'package:carrent/models/user_profile.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/account/edit_profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/network/network_client.dart';

class PayPalScreen extends StatefulWidget {
  @override
  _PayPalScreenState createState() => _PayPalScreenState();
}

class _PayPalScreenState extends State<PayPalScreen> {
  var results = [
    {
      "firstname": "ayat",
      "lastname": "khnefes",
      "location": "Damascus",
      "from": "1/4/2021",
      "to":"9/4/2021",
      "total": "2500",
      "method":"PayPal"
    },
  ];

  RangeValues _currentRangeValues = const RangeValues(40, 80);
  bool serverError = false, connectedToNetwork = true;
  Future<UserProfile> model;

  @override
  void initState() {
    super.initState();
//    initialize();
  }
//
//  void initialize() {
//    NetworkConnection.isConnected().then((connected) {
//      setState(() {
//        serverError = false;
//        if (connected) {
//          model = AppRequests.fetchProfile().catchError((error, stackTrace){
//            setState(() {
//              serverError = true;
//            });
//          });
//        }
//        connectedToNetwork = connected;
//      });
//    });
//  }
  var optionMap = {
    "option0": "  VISA",
    "option1": 'PAYPAL',
    "option2": 'MASTERCARD',
  };
  var dropdownValue = "option0";
  TextEditingController cardnumberTextEditingController =
  new TextEditingController();
  TextEditingController cardholderTextEditingController =
  new TextEditingController();
  TextEditingController cvcTextEditingController =
  new TextEditingController();
  TextEditingController methodTextEditingController =
  new TextEditingController();



  final _formKey = GlobalKey<FormState>();
//
  bool error = false;

  Future<http.Response> saveMeal(
      url, cardnumber, cardholder, method, cvc) async {
    var baseUrl = network_client.Url;
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cardnumber': cardnumber,
        'cardholder': cardholder,
        'method': method,
        'cvc': cvc,
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
          title: Text(
            "paymentdetails",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ).tr(),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        body:
//      Builder(
//          builder: (context) {
//            if (connectedToNetwork == false) {
//              return NoInternetConnection(voidCallback: initialize);
//            } else {
//              if (serverError) {
//                return ServerError(voidCallback: initialize);
//              } else {
//                return FutureBuilder<UserProfile>(
//                  future: model,
//                  builder: (context, snapshot) {
//                    if(snapshot.hasData){
//                      return
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover)),

          child: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 10.0,
                  child: Form(
//                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//
                        Column(

                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              margin:
                              EdgeInsets.symmetric(horizontal: 25,vertical: 30),
//                            margin: EdgeInsets.only(
//                                bottom: 20, left: 40, right: 40),
//                            padding: EdgeInsets.only(left: 40, right: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: TextFormField(
//                            controller: cardholderTextEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "cardholder".tr(),
                                    icon: Icon(Icons.person)),
                                validator: (String value) {
                                  if (value.isEmpty || value.length < 1) {
                                    return "validcardholdername".tr();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                              Container(
                                margin:
                                EdgeInsets.only(left: 25,right: 25,bottom: 30),                                padding: EdgeInsets.only(left: 40, right: 40),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                child: TextFormField(
//                              controller: cardnumberTextEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "cardnumber".tr(),
                                      icon: Icon(Icons.credit_card)),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "validcardnumber".tr();
                                    }
                                    if (value.length < 20 || value.length > 20) {
                                      return "validcardnumberlength".tr();
                                    }
                                  },
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30, left: 25, right: 25),
                          padding: EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: TextFormField(
//                            controller: cvcTextEditingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "securitycode".tr(),
                                icon: Icon(Icons.code)),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "validCVC".tr();
                              }
                              if (value.length < 10 || value.length > 10) {
                                return "validCVClength".tr();
                              }

                            },
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.only(
                              top: 20, bottom: 40, left: 30, right: 30),
//                        padding: EdgeInsets.only(left: 30),
                          height: 50,
                          decoration: BoxDecoration(
//                              color: primaryColor5,
                              gradient: LinearGradient(
                                  colors: [primaryColor5, primaryColor6],
                                  begin: FractionalOffset.centerRight,
                                  end: FractionalOffset.centerLeft,
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),)),
                          child: FlatButton(
//                      minWidth: double.infinity,
//                      padding: EdgeInsets.symmetric(vertical: 10),
//                      color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            onPressed: () async {
//                              FocusScope.of(context).unfocus();
//                              setState(() {
//                                error = false;
//                              });
//                              if (_formKey.currentState.validate()) {
//                                var res = await saveMeal(
//                                    "api/auth/register",
//                                    cardnumberTextEditingController.text,
//                                    cardholderTextEditingController.text,
//                                    methodTextEditingController.text,
//                                    cvcTextEditingController.text,
//                                    );
////                                print(json.decode(res.body)['data']);
//                                if (res.statusCode == 200) {
////
////
////                            Phoenix.rebirth(context);
//                                } else {
//                                  setState(() {
//                                    error = true;
//                                  });
//                                }
//                              }
                            },

                            child: Center(
                              child: Text(
                                "pay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).tr(),
                            ),
                          ),
//                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
//          child: Container(
//            margin: EdgeInsets.only(top: 60),
//            padding: EdgeInsets.symmetric(vertical: 40,horizontal: 3),
////                          color: primaryColor3,
//
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: [
//
////                Container(
////                  height: 530,
////                  child: Center(
////                    child: Card(
////                      shadowColor: Colors.grey,
////                      elevation: 10,
////                      child: Column(
////                        children: [
////                          Container(
////                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
////                            child: Row(
////                              children: [
////                                Text("Card Holder : ",style: TextStyle(
////                                    fontSize: 20,
////                                    color: primaryColor5,
////                                    fontWeight: FontWeight.bold),),
//////
////                                Padding(padding: EdgeInsets.only(left: 20)),
////                                Text(
//////                                              snapshot.data.phoneNumber,
////                                  results[0]["firstname"]+" "+results[0]["lastname"],
////                                  style: TextStyle(
////                                      fontSize: 20,
////                                      color: Colors.grey,
////                                      fontWeight: FontWeight.bold,
////                                  ),
////                                )
////                              ],
////                            ),
////                          ),
////                          Container(
////                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
////                            child: Row(
////                              children: [
////                                Text("Payment Method : ",style: TextStyle(
////                                    fontSize: 20,
////                                    color: primaryColor5,
////                                    fontWeight: FontWeight.bold),),
//////
////                                Padding(padding: EdgeInsets.only(left: 20)),
////                                Text(
//////                                              snapshot.data.phoneNumber,
////                                  results[0]["method"],
////                                  style: TextStyle(
////                                      fontSize: 20,
////                                      color: Colors.grey,
////                                      fontWeight: FontWeight.bold),
////                                )
////                              ],
////                            ),
////                          ),
//////
//////                                      Divider(color: primaryColor5,),
////
////                          Column(
////                            children: [
////                              Container(
////
////                                child: Text("Card Number : ",style: TextStyle(
////                                    fontSize: 20,
////                                    color: primaryColor5,
////                                    fontWeight: FontWeight.bold),),
////                              ),
////                              Container(
////                                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
////                                padding: EdgeInsets.only(left: 40, right: 40),
////                                decoration: BoxDecoration(
////                                    color: Colors.white,
////                                    borderRadius: BorderRadius.circular(5),
////                                    border: Border.all(color: Colors.grey)),
////                                child: TextFormField(
//////                              controller: phone_numberTextEditingController,
////                                  keyboardType: TextInputType.number,
////                                  decoration: InputDecoration(
////                                      border: InputBorder.none,
////                                      hintText: "Card Number ",
////                                      icon: Icon(Icons.credit_card)),
////                                  validator: (String value) {
////                                    if (value.isEmpty) {
////                                      return "validcardnumber";
////                                    }
////                                    if (value.length < 20 || value.length > 20) {
////                                      return "validphonelength";
////                                    }
////                                  },
////                                ),
////                              ),
////                            ],
////                          ),
////                          Divider(color: primaryColor5,thickness: 2),
//////                          Container(
//////                            padding: EdgeInsets.only(left:20,right: 20,top: 20,bottom: 10),
//////                            child: Row(
//////                              children: [
//////                                Text("Location : ",style: TextStyle(
//////                                    fontSize: 20,
//////                                    color: primaryColor5,
//////                                    fontWeight: FontWeight.bold),),
////////
//////                                Padding(padding: EdgeInsets.only(left: 20)),
//////                                Text(
////////                                              snapshot.data.phoneNumber,
//////                                  results[0]["location"],
//////                                  style: TextStyle(
//////                                      fontSize: 20,
//////                                      color: Colors.grey,
//////                                      fontWeight: FontWeight.bold),
//////                                )
//////                              ],
//////                            ),
//////                          ),
//////                          Divider(color: primaryColor5,),
//////                          Container(
//////                            padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
//////                            child: Row(
//////                              children: [
//////                                Text("Date From : ",style: TextStyle(
//////                                    fontSize: 20,
//////                                    color: primaryColor5,
//////                                    fontWeight: FontWeight.bold),),
////////
//////                                Padding(padding: EdgeInsets.only(left: 20)),
//////                                Text(
////////                                              snapshot.data.phoneNumber,
//////                                  results[0]["from"],
//////                                  style: TextStyle(
//////                                      fontSize: 20,
//////                                      color: Colors.grey,
//////                                      fontWeight: FontWeight.bold),
//////                                )
//////                              ],
//////                            ),
//////                          ),
//////                          Divider(color: primaryColor5,),
//////                          Container(
//////                            padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
//////                            child: Row(
//////                              children: [
//////                                Text("Date To : ",style: TextStyle(
//////                                    fontSize: 20,
//////                                    color: primaryColor5,
//////                                    fontWeight: FontWeight.bold),),
////////
//////                                Padding(padding: EdgeInsets.only(left: 20)),
//////                                Text(
////////                                              snapshot.data.phoneNumber,
//////                                  results[0]["to"],
//////                                  style: TextStyle(
//////                                      fontSize: 20,
//////                                      color: Colors.grey,
//////                                      fontWeight: FontWeight.bold),
//////                                )
//////                              ],
//////                            ),
//////                          ),
//////                          Divider(color: primaryColor5,),
//////                          Container(
//////                            padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
//////                            child: Row(
//////                              children: [
//////                                Text("Total Amount : ",style: TextStyle(
//////                                    fontSize: 20,
//////                                    color: primaryColor5,
//////                                    fontWeight: FontWeight.bold),),
////////
//////                                Padding(padding: EdgeInsets.only(left: 20)),
//////                                Text(
////////                                              snapshot.data.phoneNumber,
//////                                  results[0]["total"],
//////                                  style: TextStyle(
//////                                      fontSize: 20,
//////                                      color: primaryColor5,
//////                                      fontWeight: FontWeight.bold),
//////                                )
//////                              ],
//////                            ),
//////                          ),
////
////                          Container(
////                            margin: EdgeInsets.only(
////                                bottom: 10, top: 30, left: 50, right: 50),
////                            height: 50,
////                            decoration: BoxDecoration(
////                              color: primaryColor5,
////                              borderRadius: BorderRadius.all(
////                                Radius.circular(25),
////                              ),
////                            ),
////                            child: FlatButton(
//////
////                              shape: RoundedRectangleBorder(
////                                  borderRadius: BorderRadius.all(Radius.circular(25))),
////                              onPressed: ()
//////                      async
////                              {
//////                      FocusScope.of(context).unfocus();
//////                      setState(() {
//////                        error = false;
//////                      });
//////                      if (_formKey.currentState.validate()) {
//////                        var res = await saveMeal("api/client/forgotpassword", emailTextEditingController.text);
//////                        print(res.statusCode);
//////                        if (res.statusCode == 200) {
//////                          SharedPreferences prefs = await SharedPreferences.getInstance();
//////                          await prefs.setString('token', json.decode(res.body)['data']['token']);
//////                          Phoenix.rebirth(context);
//////                        } else {
//////                          setState(() {
//////                            error = true;
//////                          });
//////                        }
//////                      }
////                              },
////
////
////                              child: Center(
////                                child: Text(
////                                  "Pay ",
////                                  style: TextStyle(
////                                    color: Colors.white,
////                                    fontWeight: FontWeight.bold,
////                                    fontSize: 20,
////                                  ),
////                                ),
////                              ),
//////                      ),
////                            ),
////                          ),
////
////                        ],
////                      ),
////                    ),
////                  ),
////                ),
////                              )
//              ],
//            ),
//          ),
        )
//        ;
//                    }
//
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  },
//                );
//              }
//            }
      //}
      //),

    );
  }
}
