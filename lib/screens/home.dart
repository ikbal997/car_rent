import 'package:carrent/app_locale.dart';
import 'package:carrent/models/terms.dart';
import 'package:carrent/screens/car/all_car.dart';
import 'package:carrent/screens/car/carByType.dart';
import 'package:carrent/screens/car/find_car.dart';
import 'package:flutter/material.dart';
import 'package:carrent/config.dart';
import 'package:carrent/models/bottom_navigation.dart';
import 'package:carrent/models/car.dart';
import 'package:carrent/models/cars.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/date_and_time.dart';
import 'package:carrent/tiles/car_list_tiles.dart';
import 'package:carrent/tiles/car_offers_list_tiles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'network/no_internet_connection.dart';
import 'network/server_error.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrent/drawer/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
//  List<NavigationItem> navigationItems = getNavigationItemList();
//  NavigationItem selectedItem;
  bool serverError = false, connectedToNetwork = true;
//  Future<Example> model;
  Cars carModel = new Cars();
  AllTerms termsModel = new AllTerms();
//  List<Car> cars = getCarList();
//  List<Dealer> dealers = getDealerList();
  bool loggedIn = false;
  var images = [
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/convertibles.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/couple.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/hatchback.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/minivans.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/sedan.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/suv.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/trucks.jpg",
    "http://rentalcar.zmnalholol.com/uploads/demo/car/terms/wagons.jpg"
  ];

  Widget buildSpecificationCar(String data, String image, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarByTypeScreen(id)));
      },
      child: Container(
        width: 160,
//      height: 90,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
//      padding: EdgeInsets.symmetric(
//        vertical: 8,
//        horizontal: 16,
//      ),
        margin: EdgeInsets.only(right: 16),
        child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//         Image.asset("images/fiat_0.png"),
            Image.network(image, fit: BoxFit.cover),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        String token = (prefs.getString('token') ?? null);
        AppLocale().token = token;
        print(AppLocale().token);
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
      });
      loggedIn = AppLocale().token != null;
//      selectedItem = navigationItems[0];
    });

    initialize();
  }

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          AppRequests.fetchCars(1).then((fetchedList) {
            carModel.cars = fetchedList.cars;
          }).catchError((error, stackTrace) {
            setState(() {
              print("this is carModel server error for filter");
              serverError = true;
            });
          });

          AppRequests.fetchAllTermsFilters().then((fetchedList) {
            termsModel.terms.addAll(fetchedList.terms);
          }).catchError((error, stackTrace) {
            setState(() {
              print("this is carModel server error for filter");
              serverError = true;
            });
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
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
//          return FutureBuilder<Cars>(
//              future: carModel,
//              builder: (context, snapshot) {
//                print("this model");
//                print(carModel);
//                if (snapshot.hasData) {
          print("there is data ************************ ");
          return Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: primaryColor5,
              elevation: 0,
              brightness: Brightness.light,
              title: Text(
                "app",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).tr(),
              actions: [
                Padding(padding: EdgeInsets.all(5),child:
                    Icon(
                      Icons.notifications,
                    )),
              ],
              centerTitle: true,
//                      actions: [
//                        Padding(
//                          padding: EdgeInsets.only(right: 16),
//                          child: Icon(
//                            Icons.menu,
//                            color: Colors.white,
//                            size: 28,
//                          ),
//                        )
//                      ],
            ),
            backgroundColor: Colors.grey[200],
//                    extendBodyBehindAppBar: true,
            body:
//                    Center(
//                      child:
                Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage("images/background Home.png"),
//                    fit: BoxFit.cover),
                  ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    CarouselSlider


                      (
                        options: CarouselOptions(
                          height: 220.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 5.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: carModel.cars.map((e) {
                          return
//                                  Card(
//                                  child:
                              CarOffersListTiles(
                            title: e.title,
                            image: e.image,
//                                  ),
                          );
                        }).toList()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(carModel.cars, (index, url) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? primaryColor5
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: Colors.grey),
                            textAlign: TextAlign.start,
                          ).tr(),
                        ),
                      ],
                    ),
                    Container(
                        height: 150,
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 16,
                        ),
                        margin: EdgeInsets.only(bottom: 10, top: 5),
                        child: ListView.builder(
                            itemCount: termsModel.terms.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return buildSpecificationCar(
                                  termsModel.terms[index].name,
                                  images[index],
                                  termsModel.terms[index].id);
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DateAndTime()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
//                                color:primaryColor5,
                                gradient: LinearGradient(
                                    colors: [primaryColor5, primaryColor6],
                                    begin: FractionalOffset.centerRight,
                                    end: FractionalOffset.centerLeft,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
//                                border: Border.all(color: Colors.grey[300], width: 2)
                                ),
                            child: Center(
                              child: Text(
                                "find",
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ).tr(),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllCar()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [primaryColor5, primaryColor6],
                                    begin: FractionalOffset.centerRight,
                                    end: FractionalOffset.centerLeft,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
//                                color: primaryColor6,
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: Colors.grey.withOpacity(0.5),
//                                    spreadRadius: 5,
//                                    blurRadius: 7,
//                                    offset: Offset(0, 3), // changes position of shadow
//                                  ),
//                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
//                                border: Border.all(color: Colors.grey[300], width: 2)
                            ),
                            child: Center(
                              child: Text(
                                "all",
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ).tr(),
                            ),
                          ),
                        ),
                      ],
                    ),

//                        GestureDetector(
//                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => DateAndTime()),
//                            );
//                          },
//                          child: Padding(
//                            padding:
//                                EdgeInsets.only(top: 16, right: 16, left: 16),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                color: primaryColor2,
//                                borderRadius: BorderRadius.all(
//                                  Radius.circular(15),
//                                ),
//                              ),
//                              padding: EdgeInsets.all(15),
//                              height: 80,
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: [
//                                      Text(
//                                        "Find a Car",
//                                        style: TextStyle(
//                                          fontSize: 22,
//                                          fontWeight: FontWeight.bold,
//                                          color: Colors.white,
//                                        ),
//                                      ),
//                                      Text(
//                                        "Book a car now",
//                                        style: TextStyle(
//                                          fontSize: 16,
//                                          color: Colors.white,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  Container(
//                                    decoration: BoxDecoration(
//                                      color: Colors.white,
//                                      borderRadius: BorderRadius.all(
//                                        Radius.circular(15),
//                                      ),
//                                    ),
//                                    height: 50,
//                                    width: 50,
//                                    child: Center(
//                                      child: Icon(
//                                        Icons.arrow_forward_ios,
//                                        color: primaryColor2,
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
                  ],
                ),
              ),
            ),
//                    ),
//                          ),
//                        ),
//          ),
//                      ],
//                    ),
//            bottomNavigationBar: Container(
//              height: 50,
//              decoration: BoxDecoration(
//                color: Colors.white,
////                          borderRadius: BorderRadius.only(
////                            topLeft: Radius.circular(30),
////                            topRight: Radius.circular(30),
////                          )
//              ),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: buildNavigationItems(),
//              ),
//            ),
          );
//                }
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              });
        }
      }
    });
  }

}
