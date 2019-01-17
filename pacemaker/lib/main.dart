import 'package:flutter/material.dart';
import 'package:pacemaker/first_column.dart';
import 'package:pacemaker/second_column.dart';
import 'package:pacemaker/third_column.dart';
import 'package:pacemaker/forth_column.dart';

void main() => runApp(MaterialApp(
  title: 'Pace Maker',
  home: new PaceMakerHome(),
));

class PaceMakerHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pace Maker'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
             Expanded(child: FirstColumn()),
             Expanded(child:SecondColumn()),
             Expanded(child:ThirdColumn()),
             Expanded(child:ForthColumn()),
    ],
    ),
    ),
    );
  }
}