import 'package:carrent/app_locale.dart';
///// Flutter code sample for RangeSlider
//
//// ![A range slider widget, consisting of 5 divisions and showing the default
//// value indicator.](https://flutter.github.io/assets-for-api-docs/assets/material/range_slider.png)
////
//// This range values are in intervals of 20 because the Range Slider has 5
//// divisions, from 0 to 100. This means are values are split between 0, 20, 40,
//// 60, 80, and 100. The range values are initialized with 40 and 80 in this demo.
//
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
///// This is the main application widget.
//class MyApp extends StatelessWidget {
//  static const String _title = 'Flutter Code Sample';
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: _title,
//      home: Scaffold(
//        appBar: AppBar(title: const Text(_title)),
//        body: MyStatefulWidget(),
//      ),
//    );
//  }
//}
//
///// This is the stateful widget that the main application instantiates.
//class MyStatefulWidget extends StatefulWidget {
//  MyStatefulWidget({Key key}) : super(key: key);
//
//  @override
//  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
//}
//
///// This is the private State class that goes with MyStatefulWidget.
//class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//  RangeValues _currentRangeValues = const RangeValues(40, 80);
//
//  @override
//  Widget build(BuildContext context) {
//    return RangeSlider(
//      values: _currentRangeValues,
//      min: 0,
//      max: 100,
//      divisions: 100,
////      activeColor: Colors.red,
////      inactiveColor: Colors.green,
//      labels: RangeLabels(
//        _currentRangeValues.start.round().toString(),
//        _currentRangeValues.end.round().toString(),
//      ),
//      onChanged: (RangeValues values) {
//        setState(() {
//          _currentRangeValues = values;
//          print(_currentRangeValues.start);
//          print(" and ");
//          print(_currentRangeValues.end);
//        });
//      },
//
//    );
//  }
//}

import 'package:carrent/screens/account/login_screen.dart';
import 'package:carrent/screens/account/my_profile_screen.dart';
import 'package:carrent/screens/car/all_car.dart';
import 'package:carrent/screens/car/find_car.dart';
import 'package:carrent/screens/multi_date.dart';
import 'package:flutter/material.dart';
import 'package:carrent/screens/date_and_time.dart';
import 'package:carrent/screens/home.dart';
import 'package:carrent/screens/map/my_map_page.dart';
import 'package:carrent/screens/pre_home.dart';
import 'package:carrent/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'translations', // <-- change patch to your
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppLocale().context =context;
    AppLocale().locale =context.locale;
    return MaterialApp(

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child:
//                LoginScreen(),
//                 AllCar(),
//                Home()
                //MultiDate()
                // DateAndTime()
                // MapSample()
                // MyMapPage(),
                // HomeMap()
                // MyMap()
                // DateAndTime()
                // Home()
                // PreHome()
                 Splash()
                // MyHomePage(title: 'Flutter Demo Home Page'),
                )));
  }
}
