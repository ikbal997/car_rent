import 'package:carrent/config.dart';
import 'package:carrent/models/car.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/car/PayPalScreen.dart';
import 'package:carrent/screens/car/review_details.dart';
import 'package:carrent/screens/map/my_map_page.dart';
import 'package:carrent/screens/multi_date.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:toast/toast.dart';

class CarDetailsScreen extends StatefulWidget {
  final int id;
  final bool showCalendar;
  final String startDate;
  final String endDate;

  CarDetailsScreen(this.id, this.showCalendar, this.startDate, this.endDate);

  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dateEndController = TextEditingController();
  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null && picked.length == 2) {
      setState(() {
        _dateStartController.text = DateFormat('yyyy-MM-dd').format(picked[0]);
        _dateEndController.text = DateFormat('yyyy-MM-dd').format(picked[1]);
      });
    }
  }

  bool serverError = false, connectedToNetwork = true;
  Future<Car> model;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          model =
              AppRequests.fetchCar(widget.id).catchError((error, stackTrace) {
            setState(() {
              serverError = true;
            });
            print(model.toString());
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  Widget buildSpecificationCar(IconData icon, String title, String data) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor3),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 25,
            color: primaryColor5,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            title,
            style: TextStyle(
              color: primaryColor5,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildCarPage(Car car) {
    List<Widget> page = new List<Widget>();
    page.add(
      Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Column(
          children: [
            Image.network(
              car.image,
              height: 180,
//                   fit: BoxFit.c,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(car.title,
                  //car[0]['title'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: primaryColor5)),
            ),
          ],
        ),
      ),
    );

    page.add(Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Text(
            "carspecification",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1,
                color: Colors.grey),
            textAlign: TextAlign.start,
          ).tr(),
        ),
      ],
    ));

    page.add(
      Container(
        height: 150,
//        padding: EdgeInsets.only(
//          top: 5,
//          left: 16,
//        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
//          crossAxisCount: 2,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          semanticChildCount: 2,
          children: [
            buildSpecificationCar(
                Icons.attach_money, "price".tr(), car.price.toString()),
            buildSpecificationCar(
                Icons.person, "seats".tr(), car.passenger.toString()),
            buildSpecificationCar(FontAwesomeIcons.shoppingBag, "bags".tr(),
                car.baggage.toString()),
            buildSpecificationCar(
                FontAwesomeIcons.car, "doors".tr(), car.door.toString()),
          ],
        ),
      ),
    );
    page.add(Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20),
                  child: Text(
                    "locationdetails",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.grey),
                    textAlign: TextAlign.start,
                  ).tr(),
                ),
              ],
            ),
            Container(
//            width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: primaryColor3),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "city",
                        style: TextStyle(
                          color: primaryColor5,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ).tr(),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        car.location.name,

                        style: TextStyle(
                          color: primaryColor5,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: [
                      Text(
                        "address",

                        style: TextStyle(
                          color: primaryColor5,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ).tr(),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        car.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: primaryColor5,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (MyMapPage(
                                map_lat: double.parse(car.map_lat),
                                map_lng: double.parse(car.map_lng),
                                zoom: double.parse(car.map_zoom.toString()),
                                address: car.address))),
                      );
                    },
                    child: Icon(
                      Icons.location_on,
                      size: 50,
                      color: primaryColor6,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ));
    page.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.showCalendar
                ? GestureDetector(
                    onTap: () async {
                      await displayDateRangePicker(context);
                      print(_dateStartController.text);
                      print(_dateEndController.text);
                    },
                    child: Icon(Icons.calendar_today),
                  )
                : Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
            Container(
//            padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
//              color: primaryColor5,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {

                    if (widget.startDate == "") {

                      if (_dateStartController.text.isEmpty ||
                          _dateEndController.text.isEmpty) {
                        print("empty date");

                        Toast.show(

                          "youshouldchoicedate".tr(),
                          context,
                          backgroundColor: primaryColor6,
                          gravity: Toast.CENTER,
                          duration: Toast.LENGTH_LONG,
                        );

                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewDetailsScreen(
                                  widget.id,
                                  _dateStartController.text,
                                  _dateEndController.text,
                                  1
                              )),
                        );
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewDetailsScreen(
                                widget.id, widget.startDate, widget.endDate,0)),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
//                      color: primaryColor5,
                      gradient: LinearGradient(
                          colors: [primaryColor6, primaryColor5],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "bookthiscar",
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
            ),
          ],
        ),
      ),
    );


    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0.0,
          title: Text(
            "cardetails",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ).tr(),
          centerTitle: true,
        ),
//        extendBodyBehindAppBar: true,
        body: Builder(builder: (context) {
          if (connectedToNetwork == false) {
            return NoInternetConnection(voidCallback: initialize);
          } else {
            if (serverError) {
              return ServerError(voidCallback: initialize);
            } else {
              return FutureBuilder<Car>(
                  future: model,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Container(
                        color: primaryColor5.withOpacity(0.1),
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: buildCarPage(snapshot.data),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  });
            }
          }
        }));
  }
}
