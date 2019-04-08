import 'package:flutter/material.dart';

class FirstColumn extends StatefulWidget {
  @override
  _FirstColumnState createState() => _FirstColumnState();
}

class _FirstColumnState extends State {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child : Text(
          'Set Minimum Speed :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ));
  }

}