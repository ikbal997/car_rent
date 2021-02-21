import 'dart:convert';
import 'package:carrent/screens/account/login_screen.dart';
import 'package:carrent/screens/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/network/network_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var optionMap = {
    "option0": "user",
    "option1": 'company',
    "option2": 'agent',
  };
  var dropdownValue = "option0";
  TextEditingController firstnameTextEditingController =
      new TextEditingController();
  TextEditingController phone_numberTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController lastnameTextEditingController =
      new TextEditingController();
  TextEditingController typeTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();

  final _formKey = GlobalKey<FormState>();
//
  bool error = false;

  Future<http.Response> Register(
      url, first_name, last_name, email, password, phone, term) async {
    var baseUrl = network_client.Url;
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phone': phone,
        'password': password,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'term': term
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColor5,
        elevation: 0,
        brightness: Brightness.light,
//          leading: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
        title: Text(
          "signup",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey[200],
          ),
        ).tr(),
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.png"), fit: BoxFit.cover)),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Card(
                shadowColor: Colors.grey,
                elevation: 10.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(bottom: 30),
//                    child: Text(
//                      "Sign Up",
//                      style: TextStyle(
//                          color: primaryColor,
//                          fontWeight: FontWeight.bold,
//                          fontSize: 40),
//                    ),
//                  ),
//                  Visibility(
//                    visible: error,
//                      child: Container(
//                        width: double.infinity,
//                        margin: EdgeInsets.only(bottom: 15),
//                    padding: EdgeInsets.symmetric(vertical: 15),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(5)),
//                      color: Colors.red,
//                    ),
//                    child: Text("emailvalidation".tr(),
//                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,),
//                  )),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        margin: EdgeInsets.only(
                            left: 25, right: 25, top: 40, bottom: 20),
//                            margin: EdgeInsets.only(
//                                bottom: 20, left: 40, right: 40),
//                            padding: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: firstnameTextEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "firstname".tr(),
                              icon: Icon(Icons.person)),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 1) {
                              return "validfirstname".tr();
                            }
                          },
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 20, left: 25, right: 25),
                        padding: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: lastnameTextEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "lastname".tr(),
                              icon: Icon(Icons.person)),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 1) {
                              return "validlastname".tr();
                            }
                          },
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 20, left: 25, right: 25),
                        padding: EdgeInsets.only(left: 40, right: 40),
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
                        margin:
                            EdgeInsets.only(bottom: 20, left: 25, right: 25),
                        padding: EdgeInsets.only(left: 40, right: 40),
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
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 10, left: 25, right: 25),
                        padding: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: passwordTextEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "password".tr(),
                              icon: Icon(Icons.lock)),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              return "validpassword".tr();
                            }
                          },
                        ),
                      ),
                      Column(
                        children: [
//                      Text(
//                        "type of user",
//                        style: TextStyle(
//                            fontSize: 18,
////                            fontWeight: FontWeight.bold,
//                            color: primaryColor),
//                        textAlign: TextAlign.center,
//                        maxLines: 1,
//                      ),
//                      Container(
//                        margin: EdgeInsets.only(bottom: 10,left: 40,right: 40),
//                        padding: EdgeInsets.only(left: 40, right: 40),
//                        decoration: BoxDecoration(
//                            color: Colors.grey,
//                            borderRadius: BorderRadius.circular(5)),
//
//                        child:  DropdownButtonHideUnderline(
//
//                          child: DropdownButton(
//                            isExpanded: true,
//                            value: dropdownValue,
//                            dropdownColor: Colors.grey,
//                            icon: Icon(Icons.arrow_downward),
//                            iconSize: 24,
//                            onChanged: (value) {
//                              setState(() {
//                                dropdownValue = value;
//                              });
////                          reloadData();
//                            },
//                            items: <String>[
//                              'option0',
//                              'option1',
//                              'option2',
//
//                            ].map<DropdownMenuItem<String>>((String value) {
//                              return DropdownMenuItem<String>(
//
//                                value: value,
//                                child: Text(optionMap[value]),
//                              );
//                            }).toList(),
//                          ),
//                        ),
//                      ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 20, bottom: 40, left: 30, right: 30),
//                        padding: EdgeInsets.only(left: 30),
                        height: 50,
                        decoration: BoxDecoration(
                            color: primaryColor5,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            )),
                        child: FlatButton(
//                      minWidth: double.infinity,
//                      padding: EdgeInsets.symmetric(vertical: 10),
//                      color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              error = false;
                            });
                            if (_formKey.currentState.validate()) {
                              var res = await Register(
                                  "api/auth/register",
                                  firstnameTextEditingController.text,
                                  lastnameTextEditingController.text,
                                  emailTextEditingController.text,
                                  passwordTextEditingController.text,
                                  phone_numberTextEditingController.text,
                                  true);
//                                print(json.decode(res.body)['data']);
                              if (res.statusCode == 200) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
//                            print(json.decode(res.body)['data']['token'].toString());
                                await
//                                prefs.setString('token',
//                                    json.decode(res.body)['data']['token']);
                                prefs.setString(
                                    'name',
                                    firstnameTextEditingController.text +
                                        "  " +
                                        lastnameTextEditingController.text);
                                await prefs.setString(
                                    'email', emailTextEditingController.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
//                            Phoenix.rebirth(context);
                              } else {
                                setState(() {
                                  error = true;
                                });
                              }
                            }
                          },

                          child: Center(
                            child: Text(
                              "save",
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
      ),
//    )
    );
  }
}
