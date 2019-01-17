import 'package:flutter/material.dart';


class FifthColumn extends StatefulWidget {
  @override
  FifthColumnState createState() => FifthColumnState();
}

class FifthColumnState extends State {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(20),
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        new StartButton(onPressed: start),
        new StopButton(onPressed: stop),
      ],
    ));
  }

  void start() {
    //todo
  }
  void stop() {
    //todo
  }
}

class StartButton extends RaisedButton {
  StartButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        width: 150,
        child: RaisedButton(

      onPressed: onPressed,
      child: new Text('START'),
      color: Colors.green,
    ));
  }
}

class StopButton extends RaisedButton {
  StopButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        width: 150,
        child: RaisedButton(
          onPressed: onPressed,
          child: new Text('STOP'),
          color: Colors.red,

    ));
  }
}