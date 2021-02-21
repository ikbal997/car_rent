import 'dart:convert';
import 'package:carrent/screens/account/forgot_screen.dart';
import 'package:carrent/screens/account/my_profile_screen.dart';
import 'package:carrent/screens/account/register_screen.dart';
import 'package:carrent/screens/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:carrent/app_locale.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/network/network_client.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool error = false;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String token = (prefs.getString('token') ?? null);
      AppLocale().token = token;

//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
    loggedIn = AppLocale().token != null;
//    buildScreens();
  }

  Future<http.Response> saveMeal(url, email, password) async {
    var baseUrl = network_client.Url;
    print(email);
    print(password);

    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[primaryColor5, primaryColor6],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 220.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(""),
//        backgroundColor: primaryColor5,
//        elevation: 0.0,
//      ),
////        extendBodyBehindAppBar: true,
////      resizeToAvoidBottomInset: false,
//      backgroundColor: Colors.grey[300],
      body: Container(
        constraints: BoxConstraints.expand(),

        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
            image: AssetImage("images/loginBack.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //        child:
//          Center(
//            child:
//            SingleChildScrollView(
//          child: Container(
//                padding: EdgeInsets.only(top: 20),
//            child:
//            SingleChildScrollView(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50)),
                Image.asset(
                  'images/logo.jpg',
                  width: 165,
                ),
//                            Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  "appname".tr(),
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient),
                ),

                Container(
                  margin:
                      EdgeInsets.only(bottom: 20, top: 20, left: 50, right: 50),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: TextFormField(
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "email".tr(),
                      icon: Icon(Icons.email),
                    ),
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
                  margin: EdgeInsets.only(bottom: 10, left: 50, right: 50),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: TextFormField(
                    controller: passwordTextEditingController,
                    obscureText: true,
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
                Container(
                  margin: EdgeInsets.only(left: 150),
                  child: GestureDetector(
                    child: Text(
                      "forget".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 30, bottom: 10, left: 50, right: 50),
//                        padding: EdgeInsets.only(left: 30),
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColor6, primaryColor5],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
//                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      )),
                  child: FlatButton(
//                      minWidth: double.infinity,
//                      padding: EdgeInsets.symmetric(vertical: 10),
//                      color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        error = false;
                      });
                      if (_formKey.currentState.validate()) {
                        var res = await saveMeal(
                            "api/auth/login",
                            emailTextEditingController.text,
                            passwordTextEditingController.text);
                        print(res.statusCode);
                        print(res.toString());
                        if (res.statusCode == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                            'token',
                            json.decode(res.body)['access_token'],
                          );
                          await prefs.setString(
                              'email', emailTextEditingController.text);

////                          Phoenix.rebirth(context);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          setState(() {
                            error = true;
                          });
                        }
                      }
                    },

                    child: Center(
                      child: Text(
                        "login".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
//                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "signup".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
//            ),
//        ),
//      ),
//        )
    );
  }
}
