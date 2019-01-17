import 'package:flutter/material.dart';

class SecondColumn extends StatefulWidget {
  @override
  SecondColumnState createState() => SecondColumnState();
}

class SecondColumnState extends State {
  double minimum = 9;

  @override
  Widget build(BuildContext context) {
    return new Center(
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new DecrementButton(onPressed : decrement),
            new Text(
              minimum.toStringAsFixed(1),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new IncrementButton(onPressed : increment)

          ],
        ));
  }

  void decrement() {
    setState(() {
      minimum -= 0.1 ;
    });
  }

  void increment() {
    setState(() {
      minimum += 0.1 ;
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