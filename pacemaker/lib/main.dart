import 'package:flutter/material.dart';
import 'package:pacemaker/first_column.dart';
import 'package:pacemaker/second_column.dart';
import 'package:pacemaker/third_column.dart';
import 'package:pacemaker/forth_column.dart';
import 'package:pacemaker/fifth_column.dart';
import 'package:pacemaker/speed_tracker.dart';

void main() => runApp(MaterialApp(
  title: 'Pace Maker',
  home: new PaceMakerHome(),
));

class PaceMakerHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
      appBar: new AppBar(
        title: new Text('Pace Maker'),
    bottom: TabBar(tabs: [
      Tab(icon: Icon(Icons.home)),
      Tab(icon: Icon(Icons.timer)),
    ]),
      ),
      body: TabBarView(children: <Widget>[
        new Center(
        child: Column(
          children: <Widget>[
             Expanded(child: FirstColumn()),
             Expanded(child:SecondColumn()),
             Expanded(child:ThirdColumn()),
             Expanded(child:ForthColumn()),
             Expanded(child: FifthColumn()),
    ],
    )),
    new SpeedTracker(),
    ]
    ),
    ));
  }
}