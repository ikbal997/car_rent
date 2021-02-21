import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carrent/config.dart';

class NoInternetConnection extends StatelessWidget {

  VoidCallback voidCallback;

  NoInternetConnection({Key key,@required this.voidCallback}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FaIcon(FontAwesomeIcons.wifi,color: Colors.black26,size: 125,),
          Text("غير متصل بالشبكة حاليا",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black26),),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child:  RaisedButton(
              color: primaryColor,
              textColor: Colors.white,
              onPressed: (){
                voidCallback();
              },
              child: Text("إعادة المحاولة"),
            ),
          )

        ],
      ),
    );
  }
}
