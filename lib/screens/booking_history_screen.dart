import 'package:carrent/config.dart';
import 'package:carrent/drawer/drawer.dart';
import 'package:carrent/models/booking_histories.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/tiles/booking_history_list_tiles.dart';
import 'package:flutter/material.dart';
import 'network/no_internet_connection.dart';
import 'network/server_error.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  bool serverError = false, connectedToNetwork = true;
  Future<BookingHistories> model;

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
          model = AppRequests.fetchBookingHistories()
              .catchError((error, stackTrace) {
            setState(() {
              serverError = true;
              print("server error");
            });
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0,
          title: Text("bookinghistory".tr(),style: TextStyle(fontSize: 24),),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
//      resizeToAvoidBottomInset: false,
//      backgroundColor: primaryColor3,
        extendBodyBehindAppBar: true,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover)),
            child: Builder(builder: (context) {
              if (connectedToNetwork == false) {
                return NoInternetConnection(voidCallback: initialize);
              } else {
                if (serverError) {
                  return ServerError(voidCallback: initialize);
                } else {
                  return FutureBuilder<BookingHistories>(
                      future: model,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("there is date ************************ ");
                          return Container(
                            child: ListView.builder(
                              itemCount: snapshot.data.bookingHistories.length,
                              itemBuilder: (BuildContext context, int i) {
                                return BookingHistoryListTiles(
                                  startDate: snapshot
                                      .data.bookingHistories[i].startDate,
                                  endDate:
                                      snapshot.data.bookingHistories[i].endDate,
                                  status:
                                      snapshot.data.bookingHistories[i].status,
                                  total:
                                      snapshot.data.bookingHistories[i].total,
                                  paid: snapshot.data.bookingHistories[i].paid,
                                  payNow:
                                      snapshot.data.bookingHistories[i].payNow,
                                );
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                }
              }
            })));
  }
}
