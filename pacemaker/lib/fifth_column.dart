import 'package:flutter/material.dart';


class FifthColumn extends StatefulWidget {
  @override
  _FifthColumnState createState() => _FifthColumnState();
}

class _FifthColumnState extends State {
  bool _tracking = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            _buildText(),
            Switch(value: _tracking, onChanged: trackSpeed)
          ],
        ));
  }

  Widget _buildText() {
    if (!_tracking) {
      return new Text(
        'Turn speedtracking on:',
        style: TextStyle(fontSize: 20),
      );
    } else {
      return new Text(
        'Turn speedtracking off:',
        style: TextStyle(fontSize: 20),
      );
    }
  }

  void trackSpeed(bool tracker) {
    setState(() {
      _tracking = tracker;
    });
  }
}


/*
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
}*/
