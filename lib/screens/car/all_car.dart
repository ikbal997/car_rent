import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carrent/models/car.dart';
import 'package:carrent/models/cars.dart';
import 'package:carrent/models/price_filter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carrent/models/score_filter.dart';
import 'package:carrent/models/terms.dart';
//import 'package:carrent/models/terms_filter.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:carrent/tiles/car_list_tiles.dart';
import 'package:carrent/tiles/car_offers_list_tiles.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:carrent/config.dart';
//import 'package:car_rental/PayPalScreen.dart';

class AllCar extends StatefulWidget {
  @override
  _AllCarState createState() => _AllCarState();
}

class _AllCarState extends State<AllCar> {
  bool _isLoading = true,
      serverError = false,
      connectedToNetwork = true,
      _hasMore = true,
      dataLoaded = false;

  _CarFetcher _carFetcher;
  Cars carModel = new Cars();
//  Future<Price_filter> filterPriceModel;
  Score_filter filterScoreModel;
//  Future<Terms_filter> filterTermsModel;
  AllTerms filterCarTypeModel = new AllTerms();
  AllTerms filterCarFeatureModel = new AllTerms();
  Cars filteringCarsModel = new Cars();
  List<Filter> filters = [];
  Filter selectedFilter;
  List<String> priceList = [];
  List<String> selectedPriceList = [];
  List<String> scoreList = [];
  List<String> selectedScoreList = [];
  List<String> carTypeList = [];
  List<String> carTypeListName = [];
  List<String> selectedCarTypeList = [];
  List<String> selectedCarTypeValue = [];
  List<String> carFeatureList = [];
  List<String> carFeatureListName = [];
  List<String> selectedCarFeatureList = [];
  List<String> selectedCarFeatureValue = [];
  List<String> carScoreList = [];
  Map<String, String> carTypeMap = new Map<String, String>();
  Map<String, String> carFeaturesMap = new Map<String, String>();
  var selectedCarTypeListInt;
  void _openPriceFilterDialog() async {
    String result = "";
    int _currentPage = 0;
    int totalPages = 0;
    RangeValues _currentRangeValues = const RangeValues(168, 600);
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      btnOkColor: primaryColor5,
      dialogType: DialogType.NO_HEADER,
      btnCancelColor: primaryColor5,
      showCloseIcon: true,
      body: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            Text(
              "selectprice",
              style: TextStyle(fontSize: 16, color: primaryColor6),
            ).tr(),
            RangeSlider(
              values: _currentRangeValues,
              min: 168,
              max: 600,
              divisions: 100,
              activeColor: primaryColor5,
              inactiveColor: primaryColor6,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
          ],
        );
      }),
      btnOkOnPress: () {
        print(_currentRangeValues.start);
        print(_currentRangeValues.end);
        _currentPage++;
        if (_currentRangeValues.start != null) {
          setState(() {
            dataLoaded = false;
            result = "price_range=" +
                _currentRangeValues.start.toString() +
                ";" +
                _currentRangeValues.end.toString();
            print(result);
            filteringCarsModel = new Cars();
            AppRequests.fetchTotalPagesFilteringCars(_currentPage, result)
                .then((value) {
              print("this is value");
              print(value);
              totalPages = value;
            }).catchError((error, stackTrace) {
              serverError = true;
            }).whenComplete(() {
              for (int i = 1; i <= totalPages; i++) {
                AppRequests.fetchFilteringCars(i, result).then((fetchedList) {
                  filteringCarsModel.cars.addAll(fetchedList.cars);
                  setState(() {
                    dataLoaded = true;
                  });
                }).catchError((error, stackTrace) {
                  serverError = true;
                });
              }
            });
          });
//          Navigator.pop(context);
        }
      },
    ).show();
  }

  void _openScoreFilterDialog(List<String> countList) async {
    String result = "";
    int _currentPage = 0;
    int totalPages = 0;
//    theme: ThemeData(
//        buttonTheme: ButtonThemeData(
//          minWidth: 10,
//          buttonColor: Colors.blueAccent,
//          shape: RoundedRectangleBorder(),
//          textTheme: ButtonTextTheme.accent,));
    await FilterListDialog.display(context,
//    FilterListWidget.showFilterList(
        headerTextColor: primaryColor5,
        allTextList: countList,
        height: 480,
        borderRadius: 20,
        headlineText: "selectscore".tr(),
        hideSearchField: true,
        allResetButonColor: primaryColor5,
        applyButonTextColor: Colors.white,
        applyButonTextBackgroundColor: primaryColor6,
        closeIconColor: primaryColor5,
        unselectedTextColor: primaryColor5,
        selectedTextBackgroundColor: primaryColor6,
//width: MediaQuery.of(context).size.width,
//        searchFieldHintText: "Search Here",

        selectedTextList: selectedScoreList, onApplyButtonClick: (list) {

      if (list != null) {
        setState(() {
          dataLoaded = false;
          selectedScoreList = List.from(list);
          for (int i = 0; i < selectedScoreList.length; i++) {
            result = result + "review_score[]=" + selectedScoreList[i];
            if (i != selectedScoreList.length - 1) {
              result = result + "&";
            }
          }
          _currentPage++;
          filteringCarsModel = new Cars();

          AppRequests.fetchTotalPagesFilteringCars(_currentPage, result)
              .then((value) {
            print("this is value");
            print(value);
            totalPages = value;
          }).catchError((error, stackTrace) {
            serverError = true;
          }).whenComplete(() {
            for (int i = 1; i <= totalPages; i++) {
              AppRequests.fetchFilteringCars(i, result).then((fetchedList) {
                filteringCarsModel.cars.addAll(fetchedList.cars);
                setState(() {
                  dataLoaded = true;
                });
              }).catchError((error, stackTrace) {
                serverError = true;
              });
            }
          });
        });
        Navigator.pop(context);
      }
    });
  }

  void _openCarTypeFilterDialog(List<String> countList) async {
    String result = "";
    int _currentPage = 0;
    int totalPages = 0;
    await FilterListDialog.display(context,
        allTextList: countList,
        headerTextColor: primaryColor5,
        height: 480,
        borderRadius: 20,
        headlineText: "selecttype".tr(),
        hideSearchField: true,
        allResetButonColor: primaryColor5,
        applyButonTextColor: Colors.white,
        applyButonTextBackgroundColor: primaryColor6,
        closeIconColor: primaryColor5,
        unselectedTextColor: primaryColor5,
        selectedTextBackgroundColor: primaryColor6,
//        searchFieldHintText: "Search Here",
        selectedTextList: selectedCarTypeList, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          dataLoaded = false;
          selectedCarTypeList = List.from(list);
//          carTypeMap.forEach((key, value) {
          for (int i = 0; i < selectedCarTypeList.length; i++) {
            print("************carTypeMap********************");
            selectedCarTypeValue.add(carTypeMap[selectedCarTypeList[i]]);
            print(selectedCarTypeValue[i]);
          }
//          print(selectedCarTypeValue);

//          }
//          );
          // selectedCarTypeValue
          for (int i = 0; i < selectedCarTypeValue.length; i++) {
            result = result + "terms[]=" + selectedCarTypeValue[i];
            if (i != selectedCarTypeValue.length - 1) {
              result = result + "&";
            }
          }
          _currentPage++;
          filteringCarsModel = new Cars();

          AppRequests.fetchTotalPagesFilteringCars(_currentPage, result)
              .then((value) {
            print("this is value");
            print(value);
            totalPages = value;
          }).catchError((error, stackTrace) {
            serverError = true;
          }).whenComplete(() {
            for (int i = 1; i <= totalPages; i++) {
              AppRequests.fetchFilteringCars(i, result).then((fetchedList) {
                filteringCarsModel.cars.addAll(fetchedList.cars);
                setState(() {
                  dataLoaded = true;
                });
              }).catchError((error, stackTrace) {
                serverError = true;
              });
            }
          });
        });
        Navigator.pop(context);
        print(selectedCarTypeList);
      }
    });
  }

  void _openCarFeatureFilterDialog(List<String> countList) async {
    String result = "";
    int _currentPage = 0;
    int totalPages = 0;
    await FilterListDialog.display(context,
        allTextList: countList,
        height: 480,
        borderRadius: 20,
        headerTextColor: primaryColor5,
        headlineText: "selectfeature".tr(),
        hideSearchField: true,
        allResetButonColor: primaryColor5,
        applyButonTextColor: Colors.white,
        applyButonTextBackgroundColor: primaryColor6,
        closeIconColor: primaryColor5,
        unselectedTextColor: primaryColor5,
        selectedTextBackgroundColor: primaryColor6,
//        searchFieldHintText: "Search Here",
        selectedTextList: selectedCarFeatureList, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          selectedCarFeatureList = List.from(list);
          for (int i = 0; i < selectedCarFeatureList.length; i++) {
            print("************carTypeMap********************");
            selectedCarFeatureValue
                .add(carFeaturesMap[selectedCarFeatureList[i]]);
            print(selectedCarFeatureValue[i]);
          }
          for (int i = 0; i < selectedCarFeatureValue.length; i++) {
            result = result + "terms[]=" + selectedCarFeatureValue[i];
            if (i != selectedCarFeatureValue.length - 1) {
              result = result + "&";
            }
          }
          _currentPage++;
          filteringCarsModel = new Cars();

          AppRequests.fetchTotalPagesFilteringCars(_currentPage, result)
              .then((value) {
            print("this is value");
            print(value);
            totalPages = value;
          }).catchError((error, stackTrace) {
            serverError = true;
          }).whenComplete(() {
            for (int i = 1; i <= totalPages; i++) {
              AppRequests.fetchFilteringCars(i, result).then((fetchedList) {
                filteringCarsModel.cars.addAll(fetchedList.cars);
                setState(() {
                  dataLoaded = true;
                });
              }).catchError((error, stackTrace) {
                serverError = true;
              });
            }
          });
        });
        Navigator.pop(context);
      }
    });
  }

  void _loadMore() {
    _isLoading = true;
    _carFetcher.fetch().then((fetchedList) {
      if (fetchedList.cars.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
          dataLoaded = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          carModel.cars.addAll(fetchedList.cars);
          filteringCarsModel.cars.addAll(fetchedList.cars);
          dataLoaded = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
//    setState(() {
//      selectedFilter = filters[0];
//    });
    _isLoading = true;
    _hasMore = true;
    _carFetcher = _CarFetcher();
//    _carFilteringFetcher=_CarFilteringFetcher();
    initialize();
  }

  void initialize() async {
//    NetworkConnection.isConnected().then((connected) {
//      setState(() {
//        serverError = false;
//        if (connected) {
//          carModel = AppRequests.fetchCars().catchError((error, stackTrace) {
//            setState(() {
//              serverError = true;
//            });
//          });
//          filterPriceModel =
//              AppRequests.fetchPriceFilters().catchError((error, stackTrace) {
////            setState(() {
////              print("this is fetchPriceFilters server error for filter");
////              serverError = true;
////            });
//          });
    await AppRequests.fetchScoreFilters().then((fetchedList) {
      filterScoreModel = fetchedList;
    }).catchError((error, stackTrace) {
      setState(() {
        print("this is fetchScoreFilters server error for filter");
        serverError = true;
      });
    });
////          filterTermsModel =
////              AppRequests.fetchTermsFilters().catchError((error, stackTrace) {
////            setState(() {
////              print("this is fetchTermsFilters server error for filter");
////              serverError = true;
////            });
////          });
    await AppRequests.fetchCarTypeTermsFilters().then((fetchedList) {
      filterCarTypeModel.terms.addAll(fetchedList.terms);
    }).catchError((error, stackTrace) {
      setState(() {
        print("this is filterCarTypeModel server error for filter");
        serverError = true;
      });
    });
    await AppRequests.fetchCarFeatureTermsFilters().then((fetchedList) {
      filterCarFeatureModel.terms.addAll(fetchedList.terms);
    }).catchError((error, stackTrace) {
      setState(() {
        print("this is filterCarFeatureModel server error for filter");
        serverError = true;
      });
    });

    carTypeListName = [];
    for (var i = 0; i < filterCarTypeModel.terms.length; i++) {
      carTypeListName.add(filterCarTypeModel.terms[i].name.toString());
    }
    carTypeList = [];
    for (var i = 0; i < filterCarTypeModel.terms.length; i++) {
      carTypeList.add(filterCarTypeModel.terms[i].id.toString());
    }
    carTypeMap = Map.fromIterables(carTypeListName, carTypeList);

    print(carTypeMap);

//          print(carTypeList);
    carFeatureListName = [];
    for (var i = 0; i < filterCarFeatureModel.terms.length; i++) {
      carFeatureListName.add(filterCarFeatureModel.terms[i].name.toString());
    }
    carFeatureList = [];
    for (var i = 0; i < filterCarFeatureModel.terms.length; i++) {
      carFeatureList.add(filterCarFeatureModel.terms[i].id.toString());
    }
    carFeaturesMap = Map.fromIterables(carFeatureListName, carFeatureList);
    carScoreList = [];
    for (var i = 1; i <= 5; i++) {
      carScoreList.add(i.toString());
    }
    _loadMore();
  }
//        connectedToNetwork = connected;
//      });
//    }
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (connectedToNetwork == false) {
        return NoInternetConnection(voidCallback: initialize);
      } else {
        if (serverError) {
          return ServerError(voidCallback: initialize);
        } else {
          filters = [];
          filters.add(Filter("Price".tr())); //.add(Filter(snapshot.data[1].title));
          filters.add(Filter("Score".tr())); //.add(Filter(snapshot.data[2].title));
          filters.add(Filter("Type".tr())); //
          filters.add(
              Filter("Features".tr())); //filters.add(Filter(snapshot.data[3].name));

          if (dataLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor5,
//                      shadowColor: Colors.black,
                elevation: 0.0,
                title: Text(
                  "find",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ).tr(),
                centerTitle: true,
              ),
//                    extendBodyBehindAppBar: true,
              backgroundColor: Colors.grey[200],
              body: filteringCarsModel.cars.length >= 0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: filteringCarsModel.cars.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CarListTiles(
                          title: filteringCarsModel.cars[index].title,
                          image: filteringCarsModel.cars[index].image,
                          id: filteringCarsModel.cars[index].id,
                          ShowCalendar: true,
                          startDate: "",
                          endDate: "",
                        );
                      })
                  : ListView.builder(
//                      padding: EdgeInsets.symmetric(horizontal: 10),
                      physics: BouncingScrollPhysics(),
                      itemCount: _hasMore
                          ? carModel.cars.length + 1
                          : carModel.cars.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= carModel.cars.length) {
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

                        return CarListTiles(
                          title: carModel.cars[index].title,
                          image: carModel.cars[index].image,
                          id: carModel.cars[index].id,
                        );
                      })
//                  : Container(child: Text("no data")
//                  )
              ,
              bottomNavigationBar: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor5.withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filters[0];
                          });
                          _openPriceFilterDialog();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            filters[0].name,
                            style: TextStyle(
                              color: selectedFilter == filters[0]
                                  ? Colors.white
                                  : Colors.grey[300],
                              fontSize: 16,
                              fontWeight: selectedFilter == filters[0]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filters[1];
                          });
                          _openScoreFilterDialog(carScoreList);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            filters[1].name,
                            style: TextStyle(
                              color: selectedFilter == filters[1]
                                  ? Colors.white
                                  : Colors.grey[300],
                              fontSize: 16,
                              fontWeight: selectedFilter == filters[1]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filters[2];
                          });
                          _openCarTypeFilterDialog(carTypeListName);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            filters[2].name,
                            style: TextStyle(
                              color: selectedFilter == filters[2]
                                  ? Colors.white
                                  : Colors.grey[300],
                              fontSize: 16,
                              fontWeight: selectedFilter == filters[2]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filters[3];
                          });
                          _openCarFeatureFilterDialog(carFeatureListName);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            filters[3].name,
                            style: TextStyle(
                              color: selectedFilter == filters[3]
                                  ? Colors.white
                                  : Colors.grey[300],
                              fontSize: 16,
                              fontWeight: selectedFilter == filters[3]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    ]),
                  )),
            );
          } else
            return Center(child: CircularProgressIndicator());
//          return FutureBuilder<List<Object>>(
////              future: filterPriceModel,
//              future: Future.wait([
////                carModel,
//                filteringCarsModel,
////                filterPriceModel,
////                filterScoreModel,
//                filterCarTypeModel,
//                filterCarFeatureModel
//              ]),
//              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                if (snapshot.hasData) {
////                  print("model");
//                  filters = [];
//                  filters.add(Filter("Price"));
////                      .add(Filter(snapshot.data[1].title));
//                  filters.add(Filter("Score")); //
////                      .add(Filter(snapshot.data[2].title));
//                  filters.add(Filter("Type")); //
//                  filters.add(Filter("Features")); //
////                  filters.add(Filter(snapshot.data[3].name));
////                  countList=snapshot.data[1].terms;
//                  carTypeList = [];
//                  for (var i = 0; i < snapshot.data[1].terms.length; i++) {
//                    carTypeList.add(snapshot.data[1].terms[i].id.toString());
//                  }
////                  carTypeListName = [];
////                  for (var i = 0; i < snapshot.data[1].terms.length; i++) {
////                    carTypeListName.add(snapshot.data[1].terms[i].name);
////                  }
//                  carFeatureList = [];
//                  for (var i = 0; i < snapshot.data[2].terms.length; i++) {
//                    carFeatureList.add(snapshot.data[2].terms[i].id.toString());
//                  }
////                  if(selectedCarTypeList.length > 0){
////                    selectedCarTypeListInt =
////                        int.parse(selectedCarTypeList[0]);
////                    _getFilteringCars(selectedCarTypeListInt);
////                  }
//
//                  return Scaffold(
//                    appBar: AppBar(
//                      backgroundColor: primaryColor5,
////                      shadowColor: Colors.black,
//                      elevation: 0.0,
//                      title: Text(
//                        "Find your car ",
//                        style: TextStyle(color: Colors.white, fontSize: 28),
//                      ),
//                      centerTitle: true,
//                    ),
////                    extendBodyBehindAppBar: true,
//                    backgroundColor: Colors.grey[200],
//                    body: Container(
//                        constraints: BoxConstraints.expand(),
//                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                              image: AssetImage("images/background.png"),
//                              fit: BoxFit.cover),
//                        ),
//                        child:
////                        selectedCarTypeList.length > 0
////                            || selectedCarFeatureList.length > 0
////                            ?
//                      ListView.builder(
//                                itemCount: snapshot.data[0].cars.length, //100,
//                                physics: BouncingScrollPhysics(),
//                                itemBuilder: (BuildContext context, int i) {
//                                  return CarListTiles(
//                                    title: snapshot.data[0].cars[i].title,
//                                    image: snapshot.data[0].cars[i].image,
//                                    id: snapshot.data[0].cars[i].id,
//                                  );
//                                },
//                              )
////                            : Container(child: Text("no data"))
//                            ),
//                    bottomNavigationBar: Container(
//                        height: 60,
//                        decoration: BoxDecoration(
//                          color: primaryColor5.withOpacity(0.8),
//                        ),
//                        child: Padding(
//                          padding: EdgeInsets.all(10),
//                          child: Row(children: [
//                            GestureDetector(
//                              onTap: () {
////                                setState(() {
////                                  selectedFilter = filters[0];
////                                });
//                                _openCarTypeFilterDialog(carTypeList);
////                                print("selectedCarTypeList");
////                                print(selectedCarTypeList);
////                                print("carTypeList");
////                                print(carTypeList);
////                                print("_getFilteringCars");
////                                if(selectedCarTypeList!=null){
////                                  selectedCarTypeListInt =
////                                      int.parse(selectedCarTypeList[0]);
////                                  _getFilteringCars(selectedCarTypeListInt);
////                                }
////                                print("selectedCarTypeListInt");
////                                print(selectedCarTypeListInt);
//                              },
//                              child: Padding(
//                                padding: EdgeInsets.only(right: 16),
//                                child: Text(
//                                  filters[2].name,
//                                  style: TextStyle(
//                                    color: selectedFilter == filters[0]
//                                        ? Colors.white
//                                        : Colors.grey[300],
//                                    fontSize: 16,
//                                    fontWeight: selectedFilter == filters[0]
//                                        ? FontWeight.bold
//                                        : FontWeight.normal,
//                                  ),
//                                ),
//                              ),
//                            ),
//
//                            GestureDetector(
//                              onTap: () {
////                                setState(() {
////                                  selectedFilter = filters[0];
////                                });
//                                _openCarFeatureFilterDialog(carFeatureList);
//                              },
//                              child: Padding(
//                                padding: EdgeInsets.only(right: 16),
//                                child: Text(
//                                  filters[3].name,
//                                  style: TextStyle(
//                                    color: selectedFilter == filters[0]
//                                        ? Colors.white
//                                        : Colors.grey[300],
//                                    fontSize: 16,
//                                    fontWeight: selectedFilter == filters[0]
//                                        ? FontWeight.bold
//                                        : FontWeight.normal,
//                                  ),
//                                ),
//                              ),
//                            )
//                          ]
//                              //buildFilters(countList),
//                              ),
//                        )),
//                  );
//                }
//
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              });
        }
      }
    });
  }

//  Widget buildFilterIcon() {
//    return Container(
//      width: 50,
//      height: 50,
//      margin: EdgeInsets.symmetric(horizontal: 16),
//      decoration: BoxDecoration(
//        color: primaryColor5,
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

//  List<Widget> buildFilters(List<String> countList) {
//    List<Widget> list = [];
//    for (var i = 0; i < filters.length; i++) {
//      list.add(buildFilter(filters[i], countList));
//    }
//    return list;
//  }

//  Widget buildFilter(Filter filter, List<String> countList) {
//    return GestureDetector(
//      onTap: () {
//        setState(() {
//          selectedFilter = filter;
//        });
//        _openCarTypeFilterDialog(countList
//            //
//            );
//      },
//      child: Padding(
//        padding: EdgeInsets.only(right: 16),
//        child: Text(
//          filter.name,
//          style: TextStyle(
//            color: selectedFilter == filter ? Colors.white : Colors.grey[300],
//            fontSize: 16,
//            fontWeight:
//                selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
//          ),
//        ),
//      ),
//    );
//  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList}) : super(key: key);
  final List<String> allTextList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          allTextList: allTextList,
          height: MediaQuery.of(context).size.height,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
        ),
      ),
    );
  }
}

class Filter {
  String name;

  Filter(this.name);
}

class _CarFetcher {
  int _currentPage = 0;
  _CarFetcher(); // This async function simulates fetching results from Internet, etc.
  Future<Cars> fetch() async {
    _currentPage++;
    return AppRequests.fetchCars(_currentPage);
  }
}

//class _CarFilteringFetcher {
//  int _currentPage = 0;
//
//  _CarFilteringFetcher(); // This async function simulates fetching results from Internet, etc.
//  Future<Cars> fetch(String terms) async {
//    _currentPage++;
//    return AppRequests.fetchFilteringCars(_currentPage, terms);
//  }
//}

//Future<Cars> _getFilteringCars(String terms) async {
//  filteringCarsModel = null;
//  await NetworkConnection.isConnected().then((connected) {
//    connectedToNetwork = connected;
//    serverError = false;
//    AppRequests.fetchFilteringCars(terms).then((fetchedList) {
//      filteringCarsModel.cars.addAll(fetchedList.cars);
//    }).catchError((error, stackTrace) {
//      serverError = true;
//    });
//  });
//
//  return filteringCarsModel;
//}
