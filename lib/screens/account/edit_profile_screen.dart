import 'package:carrent/config.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:carrent/screens/account/my_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:carrent/network/network_client.dart';
import 'package:carrent/app_locale.dart';

import 'package:toast/toast.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  EditProfileScreen(this.userProfile);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var optionMap = {
    "option0": "user",
    "option1": 'company',
    "option2": 'agent',
  };
  var dropdownValue = "option0";
  TextEditingController firstnameTextEditingController =
  new TextEditingController();
  TextEditingController lastnameTextEditingController =
  new TextEditingController();
  TextEditingController phone_numberTextEditingController =
  new TextEditingController();
  TextEditingController emailTextEditingController =
  new TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<http.Response> saveMeal(
      url, phone_number, firstname, lastname, email) async {
    var baseUrl = network_client.Url;
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':"Bearer " + AppLocale().token
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMjk0MzU5NSwiZXhwIjoxNjEzMDI5OTk1LCJuYmYiOjE2MTI5NDM1OTUsImp0aSI6Im5mcEFGWlFGdHg5aHB6SzEiLCJzdWIiOjI4LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.6f9ZMsypIPAzqQ-3lddIFmu6-QW4xdo-b9Oul1Ew7Dg"

//            + AppLocale().token
      },
      body: jsonEncode(<String, String>{
        'phone': phone_number,
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    firstnameTextEditingController.text = widget.userProfile.firstname;
    lastnameTextEditingController.text = widget.userProfile.lastname;
    phone_numberTextEditingController.text = widget.userProfile.phoneNumber;
    emailTextEditingController.text = widget.userProfile.email;
  }

  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0,
//          leading: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
          brightness: Brightness.light,
          title: Text(
            "editprofile",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ).tr(),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover
                )),
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40),
                  width: 380,
                  height: 500,
//            padding: EdgeInsets.all(10),
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 10.0,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: TextFormField(
                              controller: firstnameTextEditingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "firstname".tr(),
                                  icon: Icon(Icons.edit)),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 1) {
                                  return "validfirstname".tr();
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: TextFormField(
                              controller: lastnameTextEditingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "lastname".tr(),
                                  icon: Icon(Icons.edit)),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 1) {
                                  return "validlastname".tr();
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: TextFormField(
                              controller: phone_numberTextEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "phonenumber".tr(),
                                  icon: Icon(Icons.phone)),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "validphone".tr();
                                }
                                if (value.length < 10 || value.length > 10) {
                                  return "validphonelength".tr();
                                }
                                if (value[0] != '0' || value[1] != '9') {
                                  return "validphonestart".tr();
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: TextFormField(
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "email".tr(),
                                  icon: Icon(Icons.email)),
                              validator: (String value) {
                                if (value.isEmpty ||
                                    value.indexOf(".") == -1 ||
                                    value.indexOf("@") == -1) {
                                  return "validemail".tr();
                                }
                              },
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState.validate()) {

                                  var res = await saveMeal(
                                      "api/auth/me",
                                      phone_numberTextEditingController.text,
                                      firstnameTextEditingController.text,
                                      lastnameTextEditingController.text,
                                      emailTextEditingController.text);
                                  print(json.decode(res.body));
                                  if (res.statusCode == 200) {
                                      Toast.show(
                                        "editprofilesuccess".tr(), context,
                                        backgroundColor: Colors.green,
                                        gravity: Toast.BOTTOM,
                                        duration: Toast.LENGTH_SHORT,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyProfileScreen()),
                                      );
////
//
                                  } else {
                                      Toast.show(
                                        "editprofileerror".tr(), context,
                                        backgroundColor: Colors.red,
                                        gravity: Toast.BOTTOM,
                                        duration: Toast.LENGTH_LONG,
                                      );
                                  }
                                }
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
                                    "edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
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
                  //),
                ),
              ),
            )));
  }
}
