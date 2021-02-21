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

class CarByTypeScreen extends StatefulWidget {
  final int id;

  CarByTypeScreen(this.id);
  @override
  _CarByTypeScreenState createState() => _CarByTypeScreenState();
}

class _CarByTypeScreenState extends State<CarByTypeScreen> {
//  List<Filter> filters = getFilterList();
//  Filter selectedFilter;
//  NavigationItem selectedItem;
//  List<NavigationItem> navigationItems = getNavigationItemList();

  bool serverError = false, connectedToNetwork = true;
//  Future<Cars> carModelByType;
  Cars carModelByType = new Cars();
  bool _hasMore = true;
  bool _isLoading = true;
  _ItemFetcher _itemFetcher;

  bool dataLoaded = false;
//  List<Car> cars = getCarList();

//  List<Dealer> dealers = getDealerList();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _itemFetcher = _ItemFetcher(widget.id);
//        selectedItem = navigationItems[0];
    initialize();
  }

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          _loadMore();
//          carModelByType =
//              AppRequests.fetchCarByType(widget.id).catchError((error, stackTrace) {
//                setState(() {
//                  serverError = true;
//                });
//              });
        }
        connectedToNetwork = connected;
      });
    });
  }

  void _loadMore() {
    _isLoading = true;
    _itemFetcher.fetch().then((fetchedList) {
      if (fetchedList.cars.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
          dataLoaded = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          carModelByType.cars.addAll(fetchedList.cars);
          dataLoaded = true;
        });
      }
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
          if (dataLoaded)
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor5,
//                      shadowColor: Colors.black,
                elevation: 0.0,
                title: Text(
                  "carsfound",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ).tr(),
                centerTitle: true,
              ),
//                    extendBodyBehindAppBar: true,
              backgroundColor: Colors.grey[200],
              body: ListView.builder(
//                padding: EdgeInsets.symmetric(horizontal: 10),
//                gridDelegate:
//                SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2,
//                    crossAxisSpacing: 10,
//                    mainAxisSpacing: 0),
                  itemCount: _hasMore
                      ? carModelByType.cars.length + 1
                      : carModelByType.cars.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= carModelByType.cars.length) {
                      // Don't trigger if one async loading is already under way
                      if (!_isLoading) {
                        _loadMore();
                      }
                      return Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 24,
                          width: 24,
                        ),
                      );
                    }
                    print(carModelByType.cars[index].title);
                    return CarListTiles(
                      id: carModelByType.cars[index].id,
                      title: carModelByType.cars[index].title,
                      image: carModelByType.cars[index].image,
                      ShowCalendar: true,
                      startDate: "",
                      endDate: "",
                    );
                  }),
            );
          else
            return Center(child: CircularProgressIndicator());
//          FutureBuilder<Cars>(
//              future: carModelByType,
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  return Scaffold(
//                    appBar: AppBar(
//                      backgroundColor: primaryColor5,
////                      shadowColor: Colors.black,
//                      elevation: 0.0,
//                      title: Text(
//                        snapshot.data.cars.length.toString()+" Cars Found",
//                        style: TextStyle(color: Colors.white, fontSize: 28),
//                      ),
//                      centerTitle: true,
//                    ),
////                    extendBodyBehindAppBar: true,
//                    backgroundColor: Colors.grey[200],
//                    body: Container(
//                      constraints: BoxConstraints.expand(),
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage("images/background.png"),
//                            fit: BoxFit.cover),
//                      ),
//                      child: ListView.builder(
//                        itemCount: snapshot.data.cars.length,
//                        physics: BouncingScrollPhysics(),
//                        itemBuilder: (BuildContext context, int i) {
//                          return CarListTiles(
//                            title: snapshot.data.cars[i].title,
//                            image: snapshot.data.cars[i].image,
//                            id: snapshot.data.cars[i].id,
//                          );
//                        },
//                      ),
//                    ),
//                  );
//                }
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              });
        }
      }
    }
//      ),
        );
  }

//  Widget buildFilterIcon() {
//    return Container(
//      width: 50,
//      height: 50,
//      margin: EdgeInsets.symmetric(horizontal: 16),
//      decoration: BoxDecoration(
//        color: kPrimaryColor,
//        borderRadius: BorderRadius.all(
//          Radius.circular(15),
//        ),
//      ),
//      child: Center(
//        child: Icon(
//          Icons.filter_list,
//          color: Colors.white,
//          size: 24,
//        ),
//      ),
//    );
//  }

//  List<Widget> buildFilters() {
//    List<Widget> list = [];
//    for (var i = 0; i < filters.length; i++) {
//      list.add(buildFilter(filters[i]));
//    }
//    return list;
//  }

//  Widget buildFilter(Filter filter) {
//    return GestureDetector(
//      onTap: () {
//        setState(() {
//          selectedFilter = filter;
//        });
//      },
//      child: Padding(
//        padding: EdgeInsets.only(right: 16),
//        child: Text(
//          filter.name,
//          style: TextStyle(
//            color: selectedFilter == filter ? kPrimaryColor : Colors.grey[300],
//            fontSize: 16,
//            fontWeight:
//                selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
//          ),
//        ),
//      ),
//    );
//  }

}

//Widget buildCar(Car car, int index) {
//  return Padding(
//    padding: EdgeInsets.symmetric(vertical: 10),
//    child: Container(
//      decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(
//          Radius.circular(10),
//        ),
//      ),
////      padding: EdgeInsets.all(10),
////    margin: EdgeInsets.only(right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
////      width: 220,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
////        Align(
////          alignment: Alignment.centerRight,
////          child: Container(
////            decoration: BoxDecoration(
////              color: kPrimaryColor,
////              borderRadius: BorderRadius.all(
////                Radius.circular(15),
////              ),
////            ),
////            child: Padding(
////              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
////              child: Text(
////                car.condition,
////                style: TextStyle(
////                  color: Colors.white,
////                  fontSize: 12,
////                  fontWeight: FontWeight.bold,
////                ),
////              ),
////            ),
////          ),
////        ),
////
////        SizedBox(
////          height: 8,
////        ),
//
//          Container(
////            height: 150,
//            child: Center(
////              child: Hero(
////                tag: car.model,
//                child: Image.asset(
//                  car.images[0],
//                  fit: BoxFit.cover,
//                ),
////              ),
//            ),
//          ),
//
//          SizedBox(
//            height: 24,
//          ),
//
//          Row(
//            children: [
//              Expanded(
//                child: Text(
//                  car.brand,
//                  style: TextStyle(
//                    fontSize: 22,
//                    fontWeight: FontWeight.bold,
//                    height: 1,
//                  ),
//                ),
//              ),
////            Text(
////              car.model,
////              style: TextStyle(
////                  fontSize: 18
////              ),
////            ),
//              Text(
//                "per " +
//                    (car.condition == "Daily"
//                        ? "day"
//                        : car.condition == "Weekly"
//                            ? "week"
//                            : "month"),
//                style: TextStyle(
//                  fontSize: 14,
//                  color: Colors.grey,
//                ),
//              ),
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//        ],
//      ),
//    ),
//  );
//}

class _ItemFetcher {
  int carId;
  int _currentPage = 0;

  _ItemFetcher(this.carId);
  // This async function simulates fetching results from Internet, etc.

  Future<Cars> fetch() async {
    _currentPage++;
    return AppRequests.fetchCarByType(carId, _currentPage);
  }
}
