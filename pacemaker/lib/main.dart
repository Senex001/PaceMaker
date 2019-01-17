import 'package:flutter/material.dart';

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
      body: new MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State {
  @override Widget build(BuildContext context) {
    return new Center(
      child: Column(
        children: <Widget>[
          //Min Speed
          Expanded(
            child: Text('Set Minimum Speed'),
          ),
          Expanded(
            child: Text('todo'),
          ),
          //Max Speed
          Expanded(
            child: Text('Set Maximum Speed'),
          ),
          Expanded(
            child: Text('todo'),
          )
        ],
      ),
    );
  }
}