import 'package:carrent/models/cars.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:carrent/tiles/car_list_tiles.dart';
import 'package:carrent/tiles/car_offers_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:carrent/config.dart';
//import 'package:car_rental/PayPalScreen.dart';
import 'package:easy_localization/easy_localization.dart';


class FindCar extends StatefulWidget {
  final int idlocation;
  final String start;
  final String end;

  FindCar(this.idlocation,this.start,this.end);

  @override
  _FindCarState createState() => _FindCarState();
}

class _FindCarState extends State<FindCar> {
//  List<Filter> filters = getFilterList();
//  Filter selectedFilter;
//  NavigationItem selectedItem;
//  List<NavigationItem> navigationItems = getNavigationItemList();
  bool serverError = false, connectedToNetwork = true;
//  Future<Example> model;
  Future<Cars> carModel;
//  List<Car> cars = getCarList();
//  List<Dealer> dealers = getDealerList();

  @override
  void initState() {
    super.initState();
    setState(() {
//      selectedItem = navigationItems[0];
    });
    initialize();
  }

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          carModel = AppRequests.fetchCarsWithDateAndTime(widget.idlocation, widget.start, widget.end).catchError((error, stackTrace) {
            setState(() {
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
    return Builder(builder: (context) {
      if (connectedToNetwork == false) {
        return NoInternetConnection(voidCallback: initialize);
      } else {
        if (serverError) {
          print("server error");
          return ServerError(voidCallback: initialize);
        } else {
          return FutureBuilder<Cars>(
              future: carModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: primaryColor5,
//                      shadowColor: Colors.black,
                      elevation: 0.0,
                      title: Text(
                        "findyourcar",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ).tr(),
                      centerTitle: true,
                    ),
//                    extendBodyBehindAppBar: true,
                    backgroundColor: Colors.grey[200],
                    body: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/background.png"),
                            fit: BoxFit.cover),
                      ),
                      child: ListView.builder(
                        itemCount: snapshot.data.cars.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          return CarListTiles(
                            title: snapshot.data.cars[i].title,
                            image: snapshot.data.cars[i].image,
                            id: snapshot.data.cars[i].id,
                            ShowCalendar: false,
                            startDate: widget.start,
                            endDate: widget.end,
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
      }
    });
  }
}
