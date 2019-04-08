import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ForthColumn extends StatefulWidget {
  @override
  _ForthColumnState createState() => _ForthColumnState();
}

class _ForthColumnState extends State {

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new DecrementButton(onPressed : decrement),
        new Text(
          globals.maxSpeed.toStringAsFixed(1),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        new IncrementButton(onPressed : increment)

      ],
    );
  }

  void decrement() {
    setState(() {
      if (globals.maxSpeed > (globals.minSpeed + 0.1)) {
        globals.maxSpeed -= 0.1;
      }
    });
  }

  void increment() {
    setState(() {
      globals.maxSpeed += 0.1 ;
    });
  }

}
class DecrementButton extends RaisedButton {
  DecrementButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: onPressed,
      child: new Icon(Icons.remove),
    );
  }
}

class IncrementButton extends RaisedButton {
  IncrementButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: onPressed,
      child: new Icon(Icons.add),
    );
  }
}