import 'package:carrent/app_locale.dart';
import 'package:carrent/config.dart';
import 'package:carrent/models/location.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/car/find_car.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/app_locale.dart';


class DateAndTime extends StatefulWidget {
  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  String _setStartDate;
  String dateStartTime;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay(hour: 00, minute: 00);
  bool serverError = false, connectedToNetwork = true;
  Future<Locations> locations;
  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dayStartController = TextEditingController();
  TextEditingController _timeStartController = TextEditingController();
  int dropdownValue;

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showRoundedDatePicker(
        context: context,
      theme: ThemeData(primarySwatch: Colors.grey),
//      theme: ThemeData.dark(),
      initialDate: selectedStartDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101),
        );
    if (picked != null)
      setState(() {
        selectedStartDate = picked;
        _dayStartController.text = DateFormat.d().format(selectedStartDate);
//        final f = new DateFormat('yyyy-MM-dd');
        _dateStartController.text =
            DateFormat('yyyy-MM-dd').format(selectedStartDate);
      });
  }

  String _setEndDate;
  String dateEndTime;
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedEndTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateEndController = TextEditingController();
  TextEditingController _dayEndController = TextEditingController();
  TextEditingController _timeEndController = TextEditingController();

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showRoundedDatePicker(
        context: context,
        theme: ThemeData(primarySwatch: Colors.grey),
        initialDate: selectedEndDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedEndDate = picked;
        _dayEndController.text = DateFormat.d().format(selectedEndDate);
        _dateEndController.text =
            DateFormat('yyyy-MM-dd').format(selectedEndDate);
      });
  }

  @override
  void initState() {
    _dayStartController.text = DateFormat.d().format(DateTime.now());
    _dateStartController.text = DateFormat.yMMM('en_US').format(DateTime.now());
    _timeStartController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    _dayEndController.text = DateFormat.d().format(DateTime.now());
    _dateEndController.text = DateFormat.yMMM('en_US').format(DateTime.now());
    _timeEndController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();


    super.initState();
    initialize();
  }

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          locations =
              AppRequests.fetchLocations().catchError((error, stackTrace) {
            setState(() {
              print("server error");
              serverError = true;
            });
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dateStartTime = DateFormat.yMd().format(DateTime.now());
    dateEndTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColor5,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'find',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ).tr(),
      ),
//      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "choosecity",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[200]),
                    textAlign: TextAlign.center,
                  ).tr(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
//                      border: Border.all(color: Colors.grey[300]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 6,
                        blurRadius: 15,
                        offset: Offset(0, 3))
                  ],
                ),
                child: FutureBuilder(
                  future: locations,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    return snapshot.hasData
                        ? Center(
                            child: Container(
                              child: DropdownButton<int>(
                                value: dropdownValue,
                                hint: Text('where').tr(),
                                items: snapshot.data.locations
                                    .map<DropdownMenuItem<int>>((item) {
                                  return DropdownMenuItem<int>(
                                    value: item.id,
                                    child: Text(item.title),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value;
                                    print(value);
                                  });
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              child: Center(
                                child: Text('load').tr(),
                              ),
                            ),
                          );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Card(
                        elevation: 10,
//                            shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(50)),
//                            ),
                        child: Container(
                          width: 130,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
//                                borderRadius: BorderRadius.all(Radius.circular(10)),
//                                border: Border.all(
//                                  color: Colors.white,
//                                  width: 1,
//                                ),
                          ),
                          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 130,
                                height: 30,
                                color: Colors.grey,
//                                    decoration: BoxDecoration(
//                                      gradient: LinearGradient(
//                                          colors: [primaryColor5, primaryColor6],
//                                          begin: FractionalOffset.centerRight,
//                                          end: FractionalOffset.centerLeft,
//                                          stops: [0.0, 1.0],
//                                          tileMode: TileMode.clamp),
//                                    ),
                                child: Text(""),
                              ),
//                                  Expanded(
//                                    child:
                              InkWell(
                                onTap: () {
                                  _selectStartDate(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(
                                            fontSize: 50, color: Colors.black),
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dayStartController,
                                        onSaved: (String val) {
                                          _setStartDate = val;
                                        },
                                        decoration: InputDecoration(
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
//                                                  labelText: 'Date: ',
//                                              labelStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.all(0)),
                                      ),
                                      TextFormField(
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[700]),
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dateStartController,
                                        onSaved: (String val) {
                                          _setStartDate = val;
                                        },
                                        decoration: InputDecoration(
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
//                                                  labelText: 'Date: ',
//                                              labelStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: 24,
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: 130,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 130,
                                height: 30,
                                color: Colors.grey,
//                                    decoration: BoxDecoration(
//                                      gradient: LinearGradient(
//                                          colors: [primaryColor5, primaryColor6],
//                                          begin: FractionalOffset.centerRight,
//                                          end: FractionalOffset.centerLeft,
//                                          stops: [0.0, 1.0],
//                                          tileMode: TileMode.clamp),
//                                    ),
                                child: Text(""),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectEndDate(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(
                                            fontSize: 50, color: Colors.black),
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dayEndController,
                                        onSaved: (String val) {
                                          _setEndDate = val;
                                        },
                                        decoration: InputDecoration(
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
//                                                  labelText: 'Date: ',
//                                              labelStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.all(0)),
                                      ),
                                      TextFormField(
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[700]),
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dateEndController,
                                        onSaved: (String val) {
                                          _setEndDate = val;
                                        },
                                        decoration: InputDecoration(
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
//                                                  labelText: 'Date: ',
//                                              labelStyle: TextStyle(color: Colors.black),
                                            contentPadding: EdgeInsets.all(10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FindCar(
                            dropdownValue,
                            _dateStartController.text,
                            _dateEndController.text)),
                  );
//                      print(_dateStartController.text);
//                      print("******");
//                      print(_dateEndController.text);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  height: 50,
                  decoration: BoxDecoration(
//                        color: primaryColor5,
                    gradient: LinearGradient(
                        colors: [primaryColor5, primaryColor6],
                        begin: FractionalOffset.centerRight,
                        end: FractionalOffset.centerLeft,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.withOpacity(0.3),
//                              spreadRadius: 4,
//                              blurRadius: 15,
//                              offset:
//                                  Offset(0, 3), // changes position of shadow
//                            ),
//                          ],
//                          border: Border.all(color: primaryColor5)
                  ),
                  child: Center(
                    child: Text(
                      "search",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
