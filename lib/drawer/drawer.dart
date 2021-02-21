import 'package:carrent/app_locale.dart';
import 'package:carrent/config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/account/change_password_screen.dart';
import 'package:carrent/screens/account/login_screen.dart';
import 'package:carrent/screens/account/my_profile_screen.dart';
import 'package:carrent/screens/booking_history_screen.dart';
import 'package:carrent/screens/home.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

enum Languages { Arabic, English }

class _DrawerState extends State<AppDrawer> {
  Languages selectedLanguage;
  bool serverError = false, connectedToNetwork = true;
  Future<UserProfile> model;
  String name = "";
  String email = "";

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          model = AppRequests.fetchProfile().catchError((error, stackTrace) {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        String token = (prefs.getString('token') ?? null);
//        name = (prefs.getString('name') ?? null);
        email = (prefs.getString('email') ?? null);
      });
      if (AppLocale().locale == Locale('ar'))
        selectedLanguage = Languages.Arabic;
      else
        selectedLanguage = Languages.English;
    });
    initialize();
  }
//  _launchURL(url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  @override
  Widget build(BuildContext context) {
    print(name + email);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
//          DrawerHeader(
//            margin: EdgeInsets.all(0),
////            decoration: BoxDecoration(
////              gradient: LinearGradient(
////                  begin: Alignment.topCenter,
////                  end: Alignment.bottomCenter,
////                  colors: [
////                    primaryColor6,
////                    Colors.grey.shade50,
////                    primaryColor6
////                  ]),
////            ),
//            child:
//            Row(
//              children: [
////                Container(
////                  child: Image.asset("images/icon.png"),
////                  width: 100,
////                  height: 100,
////                  padding: EdgeInsets.all(10),
////                  margin: EdgeInsets.only(left: 5, right: 10),
////                ),
////                Text(
////                  "Car Rental",
////                  style: TextStyle(
////                      color: primaryColor5,
////                      fontSize: 35,
////                      fontWeight: FontWeight.bold),
////                ).tr(),
//              ],
//            ),
//          ),

          Container(
              height: 150,
              width: 100,
//            constraints: BoxConstraints.expand(),
//            color: Colors.green,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  image: AssetImage("images/loginBack.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:110,right: 15,left: 15),
                child: Text(
                  email,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              )
//            UserAccountsDrawerHeader(
//              accountName: Text(
//                // snapshot.data.firstname+" "+snapshot.data.lastname,
//                "",
//                style: TextStyle(fontSize: 20, color: Colors.black),
//              ),
//              accountEmail: Text(
//                  email
//                  //snapshot.data.email
//                  ,
//                  style: TextStyle(color: Colors.grey)),
//              currentAccountPicture: GestureDetector(
//                child: new CircleAvatar(
//                  backgroundColor: primaryColor5,
//                  child: Icon(
//                    Icons.person,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//              decoration: BoxDecoration(color: Colors.grey[100]),
//            ),
              ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            title: Text(
              'home'.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: Icon(Icons.home, color: primaryColor6),
          ),
//          ListTile(
//            onTap: () {
////              Navigator.push(context,
////                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
//            },
//            title: Text(
//              "my wallet",
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.bold,
//                  color: primaryColor5),
//            ),
//            leading:
//            Icon(Icons.attach_money, color: primaryColor6),
//          ),
//          ListTile(
//            onTap: () {
////              Navigator.push(context,
////                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
//            },
//            title: Text(
//              "verification",
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.bold,
//                  color: primaryColor5),
//            ),
//            leading:
//            Icon(Icons.check, color: primaryColor6),
//          ),
//          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new BookingHistoryScreen()));
            },
            title: Text(
              "bookinghistory".tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: Icon(Icons.history, color: primaryColor6),
          ),

          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfileScreen()));
            },
            title: Text(
              "myprofile".tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: Icon(Icons.person_outline, color: primaryColor6),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ChangePasswordScreen()));
            },
            title: Text(
              "changepassword".tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: Icon(Icons.lock_outline_rounded, color: primaryColor6),
          ),
          AppLocale().token == null
              ? Container()
              : ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new LoginScreen()));
//                        .then((value){
//                      Phoenix.rebirth(AppLocale().context);
//                    });
                  },
                  title: Text(
                    "logout".tr(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor5),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: primaryColor6,
                  ),
                ),
          Divider(),
          ListTile(
            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => ProductCategoryScreen()));
            },
            title: Text(
              'aboutus'.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: Icon(Icons.info_outline, color: primaryColor6),
          ),
          ListTile(
            onTap: () {
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
//                        Phoenix.rebirth(context);
                      });
                  } else {
                    if (context.locale != Locale('en'))
                      setState(() {
                        context.locale = Locale('en');
//                        Phoenix.rebirth(context);
                      });
                  }
                },
              )..show();
            },
            title: Text(
              "language".tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor5),
            ),
            leading: FaIcon(FontAwesomeIcons.language, color: primaryColor6),
          ),
          Divider(),
//          Container(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                InkWell(
//                  onTap: () {
////                    _launchURL
////                        .call('https://www.facebook.com/alpharabi.company/');
//                  },
//                  child: Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50),
//                        color: Colors.transparent),
//                    child: Container(
////                      padding: EdgeInsets.all(10),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50),
//                        color: Colors.transparent,
//                      ),
//                      child: FaIcon(
//                        FontAwesomeIcons.facebook,
//                        color: primaryColor5,
//                        size: 30,
//                      ),
//                    ),
//                  ),
//                ),
//                InkWell(
//                  onTap: () {
////                    _launchURL.call(
////                        'https://instagram.com/alpharabi.company?igshid=dnssyedo1zc9');
//                  },
//                  child: Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50),
//                        color: Colors.transparent),
//                    child: Container(
////                      padding: EdgeInsets.all(10),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(50),
//                          color: Colors.transparent),
//                      child: FaIcon(FontAwesomeIcons.instagram,
//                          color: primaryColor5, size: 30),
//                    ),
//                  ),
//                ),
//                InkWell(
//                  onTap: () {
////                    _launchURL.call('http://alpharabi.com/index.php');
//                  },
//                  child: Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50),
//                        color: Colors.transparent),
//                    child: Container(
////                      padding: EdgeInsets.all(10),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(50),
//                          color: Colors.transparent),
//                      child: FaIcon(FontAwesomeIcons.globe,
//                          color: primaryColor5, size: 30),
//                    ),
//                  ),
//                )
//              ],
//            ),
//          )
        ],
      ),
    );
  }

  void doChange(Languages value) {}
}
