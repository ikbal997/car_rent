import 'package:carrent/config.dart';
import 'package:carrent/screens/car/car_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//"id,brand,model,price,condition,image,color,gearbox,seat,motor,speed,topSpeed

class CarListTiles extends StatelessWidget {
  final String title;
  final String image;
  final int id;
  final bool ShowCalendar;
  final String startDate;
  final String endDate;

  CarListTiles({this.id,this.title, this.image,this.ShowCalendar,this.startDate,this.endDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            PageTransition(type: PageTransitionType.fade, alignment: Alignment.center,
                child: CarDetailsScreen(this.id,ShowCalendar,startDate,endDate)));

//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) =>
//                    CarDetailsScreen(this.id,ShowCalendar,startDate,endDate)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor5.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
//      margin: EdgeInsets.only(right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//        Align(
//          alignment: Alignment.centerRight,
//          child: Container(
//            decoration: BoxDecoration(
//              color: primaryColor,
//              borderRadius: BorderRadius.all(
//                Radius.circular(15),
//              ),
//            ),
//            child: Padding(
//              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//              child: Text(
//                car.condition,
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 12,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//          ),
//        ),
              Container(
                height: 150,
                child: Center(
                  child: Image.network(
                    image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
//              color: Colors.grey[300],
//              height: 80,
                child: Center(
                  child: Text(title,style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold),),
                ),
              ),

//          SizedBox(
//            height: 24,
//          ),

//          Text(
//            price.toString(),
//            style: TextStyle(
//                fontSize: 18
//            ),
//          ),
            ],
          ),
        ),
      ),
    );
  }
}
