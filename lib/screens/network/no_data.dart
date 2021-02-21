import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoData extends StatelessWidget {

  String text;
  NoData({Key key,@required this.text}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: FaIcon(FontAwesomeIcons.plus,color: Colors.black26,size: 125,),
            ),
            Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black26),textAlign: TextAlign.center,),
          ],
        ),
      )
    );
  }
}
