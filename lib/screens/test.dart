import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text("testLanguage").tr()
    );
  }
}
