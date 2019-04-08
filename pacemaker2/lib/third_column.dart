import 'package:flutter/material.dart';


class ThirdColumn extends StatefulWidget {
  @override
  _ThirdColumnState createState() => _ThirdColumnState();
}

class _ThirdColumnState extends State {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child : Text(
          'Set Maximum Speed :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ));
  }

}