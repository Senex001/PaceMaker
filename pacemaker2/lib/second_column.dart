import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class SecondColumn extends StatefulWidget {
  @override
  _SecondColumnState createState() => _SecondColumnState();
}

class _SecondColumnState extends State {

  @override
  Widget build(BuildContext context) {
    return new Center(
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new _DecrementButton(onPressed : decrement),
            new Text(
              globals.minSpeed.toStringAsFixed(1),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new _IncrementButton(onPressed : increment)

          ],
        ));
  }

  void decrement() {
    setState(() {
      globals.minSpeed -= 0.1 ;
    });
  }

  void increment() {
    setState(() {
      if (globals.minSpeed < (globals.maxSpeed -0.1)) {
        globals.minSpeed += 0.1;
      }
    });
  }

}

class _DecrementButton extends RaisedButton {
  _DecrementButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: onPressed,
      child: new Icon(Icons.remove),
    );
  }
}

class _IncrementButton extends RaisedButton {
  _IncrementButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: onPressed,
      child: new Icon(Icons.add),
    );
  }
}