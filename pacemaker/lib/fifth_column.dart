import 'package:flutter/material.dart';


class FifthColumn extends StatefulWidget {
  @override
  _FifthColumnState createState() => _FifthColumnState();

  bool getTracking() {
    return _FifthColumnState()._tracking;
  }
}

class _FifthColumnState extends State with AutomaticKeepAliveClientMixin {
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

  @override
  bool get wantKeepAlive => true;
}