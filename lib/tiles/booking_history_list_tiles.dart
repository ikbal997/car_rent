import 'package:carrent/config.dart';
import 'package:carrent/screens/car/car_details.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

//"id,brand,model,price,condition,image,color,gearbox,seat,motor,speed,topSpeed

class BookingHistoryListTiles extends StatelessWidget {
//  final String title;
//  final String image;
//  final int id;
  final String startDate;
  final String endDate;
  final String total;
  final String status;
  final String paid;
  final String payNow;

  BookingHistoryListTiles(
      {this.startDate,
      this.endDate,
      this.total,
      this.status,
      this.paid,
      this.payNow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Icons.date_range,
                      color: primaryColor6,
                      size: 24,
                    ),
                  ),
                  Text(
                    "startdate".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor5),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(startDate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[600])),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Icons.date_range,
                      color: primaryColor6,
                      size: 24,
                    ),
                  ),
                  Text(
                    "enddate".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor5),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(endDate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[600])),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Icons.description,
                      color: primaryColor6,
                      size: 24,
                    ),
                  ),
                  Text(
                    "status".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor5),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
//                margin: EdgeInsets.only(top: 10),
                  child: Text(status,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[600])),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Icons.attach_money,
                      color: primaryColor6,
                      size: 24,
                    ),
                  ),
                  Text(
                    "total".tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor5),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
//                margin: EdgeInsets.only(top: 10),
                  child: Text(total,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[600])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
