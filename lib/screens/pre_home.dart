import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrent/screens/account/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:carrent/app_locale.dart';
import 'package:carrent/config.dart';
import 'package:carrent/screens/home.dart';
import 'package:carrent/screens/test.dart';

class PreHome extends StatefulWidget {
  @override
  _PreHomeState createState() => _PreHomeState();
}

enum Languages { Arabic, English }

class _PreHomeState extends State<PreHome> {
  Languages selectedLanguage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (AppLocale().locale == Locale('ar'))
      selectedLanguage = Languages.Arabic;
    else
      selectedLanguage = Languages.English;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.darken),
          image: AssetImage("images/loginBack.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(top: 300),
          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  "welcome".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                minWidth: 80,
                height: 35,
                color: primaryColor5, //Colors.blue[400],
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    btnOkColor: primaryColor5,
                    dialogType: DialogType.NO_HEADER,
                    padding: EdgeInsets.all(10),
                    body: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            RadioListTile<Languages>(
                              title: const Text('العربية'),
                              value: Languages.Arabic,
                              groupValue: selectedLanguage,
                              onChanged: (Languages value) {
                                setState(() {
                                  selectedLanguage = value;
                                });
                              },
                            ),
                            RadioListTile<Languages>(
                              title: const Text('English'),
                              value: Languages.English,
                              groupValue: selectedLanguage,
                              onChanged: (Languages value) {
                                setState(() {
                                  selectedLanguage = value;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    title: 'This is Ignored',
                    desc: 'This is also Ignored',
                    btnOkOnPress: () {
                      if (selectedLanguage == Languages.Arabic) {
                        if (context.locale != Locale('ar'))
                          setState(() {
                            context.locale = Locale('ar');
                          });
                      } else {
                        if (context.locale != Locale('en'))
                          setState(() {
                            context.locale = Locale('en');
                          });
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (LoginScreen())));

                    },
                  )..show();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.translate,
                      color: Colors.white,
                      size: 18,
                    ),
                    Text("  "),
                    Text(
                      "choiceLanguage".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
