import 'dart:convert';

import 'package:carrent/app_locale.dart';
import 'package:carrent/config.dart';
import 'package:carrent/models/car.dart';
import 'package:carrent/network/network_client.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/CongratulationsScreen.dart';
import 'package:carrent/screens/car/PayPalScreen.dart';
import 'package:carrent/screens/car/car_details.dart';
import 'package:carrent/screens/car/checkout_screen.dart';
import 'package:carrent/screens/date_and_time.dart';
import 'package:carrent/screens/multi_date.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ReviewDetailsScreen extends StatefulWidget {
  final int id;
  final String startDate;
  final String endDate;
  final int backdate;

  ReviewDetailsScreen(this.id, this.startDate, this.endDate,this.backdate);

  @override
  _ReviewDetailsScreenState createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  bool serverError = false, connectedToNetwork = true;
  Future<Car> model;

  var results = [
    {
      "image": "images/fiat_0.png",
      "title": "Toyota Prius Plus ",
      "f-time": "10:39 AM",
      "from": "1/4/2021",
      "t-time": "10:39 PM",
      "to": "9/4/2021",
      "total": "AED 4,180,00",
      "days": "4",
      "charge": "AED 100.00"
    },
  ];
//  var optionMap = {
//    "option0": "OFFLINE",
//    "option1": 'PAYPAL',
//  };
//  var dropdownValue = "option0";
  bool error = false;
  String booking_code = "";
//    "service_id": "11",
//    "service_type": "car",
//    "number":"1",
//    "start_date":"2021-03-12",
//    "end_date":"2021-03-15"

  Future<http.Response> booking(
      url, service_id, service_type, number, start_date, end_date) async {
    var baseUrl = network_client.Url;
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + AppLocale().token
      },
      body: jsonEncode(<String, String>{
        'service_id': service_id,
        'service_type': service_type,
        'number': number,
        'start_date': start_date,
        'end_date': end_date
      }),
    );
  }

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

  Widget buildBookDetailsCar(String title, String data1) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: primaryColor5,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
//        SizedBox(
//          height: 10,
//        ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Text(
//          "date".tr() +
            data1,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
//          ),
        ],
//      ),
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

//    page.add(
//      Divider(color: Colors.grey),
//    );
    page.add(Row(
      children: [
        SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(children: [
                buildBookDetailsCar("pick-updetails".tr(), widget.startDate),
                Text("                "),
                buildBookDetailsCar("drop-offdetails".tr(), widget.endDate),
              ])),
        ),
      ],
    ));
    DateTime Sdate = DateTime.parse(widget.startDate);
    DateTime Edate = DateTime.parse(widget.endDate);
    page.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "bookingdays",
                style: TextStyle(
                    fontSize: 18,
                    color: primaryColor5,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
            Text(
//                                              snapshot.data.phoneNumber,
              (Edate.difference(Sdate).inDays+1).toString(),
//              results[0]["days"],
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
//    page.add(Column(
//      children: [
//        Divider(
//          color: Colors.grey[300],
//          thickness: 1,
//        ),
//        Container(
//          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//          child: Row(
//            children: [
//              Expanded(
//                child: Text(
//                  "charges",
//                  style: TextStyle(
//                      fontSize: 18,
//                      color: primaryColor5,
//                      fontWeight: FontWeight.bold),
//                ).tr(),
//              ),
//              Text(
////                                              snapshot.data.phoneNumber,
//                results[0]["charge"],
//                style: TextStyle(
//                    fontSize: 18,
//                    color: primaryColor5,
//                    fontWeight: FontWeight.bold),
//              ),
//            ],
//          ),
//        ),
//      ],
//    ));
    page.add(Column(
      children: [
        Divider(color:primaryColor5),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "RentalPrice",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor5,
                      fontWeight: FontWeight.bold),
                ).tr(),
              ),
              Text(
//                                              snapshot.data.phoneNumber,
//                results[0]["total"]
                ( car.price*(Edate.difference(Sdate).inDays+1)).toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    ));
    page.add(Column(
      children: [
//        Divider(
//          color: Colors.grey,
//        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  car.bookingFee[0].name+" :",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor5,
                      fontWeight: FontWeight.bold),
                ).tr(),
              ),
              Text(
//                                              snapshot.data.phoneNumber,
//                results[0]["total"]
                (int.parse(car.bookingFee[0].price)).toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    ));
    page.add(Column(
      children: [
//        Divider(
//          color: Colors.grey,
//        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  car.bookingFee[1].name+" :",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor5,
                      fontWeight: FontWeight.bold),
                ).tr(),
              ),
              Text(
//                                              snapshot.data.phoneNumber,
//                results[0]["total"]
                (int.parse(car.bookingFee[1].price)).toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Divider(color:primaryColor5)
      ],
    ));

    page.add(Column(
      children: [
//        Divider(
//          color: Colors.grey,
//        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "totalprice",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor5,
                      fontWeight: FontWeight.bold),
                ).tr(),
              ),
              Text(
//                                              snapshot.data.phoneNumber,
//                results[0]["total"]
                ( car.price*(Edate.difference(Sdate).inDays+1) + int.parse(car.bookingFee[0].price)+int.parse(car.bookingFee[1].price)).toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: primaryColor5,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ));

    page.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          setState(() {
            Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 24,
                width: 24,
              ),
            );
            error = false;
          });

          var res = await booking(
              "api/booking/addToCart",
              widget.id.toString(),
              "car",
              "1",
              widget.startDate.toString(),
              widget.endDate.toString());

          print(widget.id.toString() +
              "  " +
              "1" +
              "  " +
              widget.startDate +
              "  " +
              widget.endDate);
          print(res.statusCode);
          print("booking_code");
          print(booking_code);
          booking_code = json.decode(res.body)['booking_code'];
          if (res.statusCode == 200) {
            print(json.decode(res.body));
            if (json.decode(res.body)['status'] == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen(booking_code)));
            } else {
              _showSheetMessage(context,widget.id,widget.backdate);
            }

//            if (dropdownValue == "option1") {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => PayPalScreen()));
//            } else if (dropdownValue == "option0") {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => CongratulationsScreen()));
//            }
          } else {
            setState(() {
              error = true;
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          height: 50,
          decoration: BoxDecoration(
//              color: primaryColor5.withOpacity(0.7),
            gradient: LinearGradient(
                colors: [primaryColor5, primaryColor6],
                begin: FractionalOffset.centerRight,
                end: FractionalOffset.centerLeft,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
//              border: Border.all(color: primaryColor5, width: 2)
          ),
          child: Center(
            child: Text(
              "docheckout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ).tr(),
          ),
        ),
      ),
    ));
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0.0,
          title: Text(
            "review",
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
                        constraints: BoxConstraints.expand(),
//                        decoration: BoxDecoration(
//                            image: DecorationImage(
//                                image: AssetImage("images/background.png"),
//                                fit: BoxFit.cover)
//                                ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: buildCarPage(snapshot.data),
                          ),
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

void _showSheetMessage(context,int id,int back ) {
  showModalBottomSheet(

    backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height / 3+50,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 60)),
                  Text(
                    "carselected",
                    style: TextStyle(
                        color: primaryColor5,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ).tr(),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    "resetchoicedate",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ).tr(),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: MaterialButton(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        height: 50,
                        decoration: BoxDecoration(
//              color: primaryColor5.withOpacity(0.7),
                          gradient: LinearGradient(
                              colors: [primaryColor5, primaryColor6],
                              begin: FractionalOffset.centerRight,
                              end: FractionalOffset.centerLeft,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
//              border: Border.all(color: primaryColor5, width: 2)
                        ),
                        child: Center(
                          child: Text(
                            "backtochoiseDate",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ).tr(),
                        ),
                      ),
                      onPressed: () {
                        if(back==1){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarDetailsScreen(id,true,"","")));

                        }
                        else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DateAndTime()));
                        }

                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
