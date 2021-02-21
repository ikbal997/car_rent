import 'package:carrent/config.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:carrent/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:carrent/network/network_client.dart';
import 'package:carrent/app_locale.dart';
import 'package:toast/toast.dart';

//import 'package:toast/toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool error = false;
  Future<http.Response> saveMeal(url, old_password, new_password) async {
    var baseUrl = network_client.Url;
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':"Bearer " + AppLocale().token
        //"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMjc3NDUyOCwiZXhwIjoxNjEyODYwOTI4LCJuYmYiOjE2MTI3NzQ1MjgsImp0aSI6Ilc5Z29PejVOZGY4SlBPS3YiLCJzdWIiOjI4LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.GJooZOmlvRxRrVzcvaIOA8lNJ_pvTdp6vnNvbzZjn4E"

        //"Bearer " + AppLocale().token
      },
      body: jsonEncode(<String, String>{
        'current-password': old_password,
        'new-password': new_password,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0,
//          leading: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
          brightness: Brightness.light,
          title: Text(
            "cahngepassword",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ).tr(),
          centerTitle: true,
        ),
//        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
//      appBar: AlpharabiAppBar(),
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(
//                padding: EdgeInsets.only(top: 30),
                width: 380,
                height: 350,
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
                          margin: EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                          padding: EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: TextFormField(
                            controller: oldPasswordTextEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "currentpassword".tr(),
                                icon: Icon(Icons.lock_open)),
                            validator: (String value) {
                              if (value.isEmpty || value.length < 1) {
                                return "emptycurrentpassword".tr();
                              }
                            },
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          padding: EdgeInsets.only(left: 40, right: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: TextFormField(
                            controller: passwordTextEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "newpassword".tr(),
                                icon: Icon(Icons.lock)),
                            validator: (String value) {
                              if (value.isEmpty || value.length < 1) {
                                return "validpassword".tr();
                              }
                            },
                          ),
                        ),
//                        Container(
//                          margin:
//                              EdgeInsets.only(bottom: 20, left: 40, right: 40),
//                          padding: EdgeInsets.only(left: 40, right: 40),
//                          decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.circular(5),
//                              border: Border.all(color: Colors.grey)),
//                          child: TextFormField(
////                      controller: confirmPasswordTextEditingController,
//                            decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: "Confirm new password",
//                                icon: Icon(Icons.check)),
//                            validator: (String value) {
//                              if (value.isEmpty || value.length < 1) {
//                                return "New password and confirm password does not match";
//                              }
//                            },
//                          ),
//                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                error = false;
                              });
                              if (_formKey.currentState.validate()) {
                                var res = await saveMeal(
                                    "api/auth/change-password",
                                    oldPasswordTextEditingController.text,
                                    passwordTextEditingController.text);
                                print(json.decode(res.body));
                                if (json.decode(res.body)['status']==true) {
                                  print(json.decode(res.body)['message']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Home()),
                                  );
                                } else {
                                  print(json.decode(res.body)['message']);
                                  Toast.show(
                                    "changing password not successfully".tr(), context,
                                    backgroundColor: Colors.red,
                                    gravity: Toast.BOTTOM,
                                    duration: Toast.LENGTH_LONG,
                                  );
                                  setState(() {
                                    error = true;
                                  });
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 40, left: 30, right: 30),
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
                                  "change",
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
            )));
  }
}
