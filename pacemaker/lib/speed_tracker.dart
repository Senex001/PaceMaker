import 'package:flutter/material.dart';
import 'package:pacemaker/fifth_column.dart';

class SpeedTracker extends StatefulWidget {
  @override
  _SpeedTrackerState createState() => _SpeedTrackerState();
}

class _SpeedTrackerState extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: _buildText()
    );
  }

  Widget _buildText() {
    if (!FifthColumn().getTracking()) {
      return new Text(
        'Speed :',
        style: TextStyle(fontSize: 20),
      );
    } else {
      return new Text(
        'Turn speedtracking on to see your current speed.',
        style: TextStyle(fontSize: 20),
      );
    }
  }
}