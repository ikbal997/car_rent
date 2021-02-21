import 'package:carrent/config.dart';
import 'package:flutter/material.dart';

//"id,brand,model,price,condition,image,color,gearbox,seat,motor,speed,topSpeed

class CarOffersListTiles extends StatelessWidget {
  final String title;
  final String image;

  CarOffersListTiles({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Colors.grey[400])
//          boxShadow: [
//            BoxShadow(
//              color: Colors.grey.withOpacity(0.2),
//              spreadRadius: 2,
//              blurRadius: 2,
//              offset: Offset(0, 2), // changes position of shadow
//            ),
//          ],
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
//                height: 150,
              child: Center(
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
//              color: Colors.grey[300],
            height: 60,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
//      ),
    );
  }
}
