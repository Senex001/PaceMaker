import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class FifthColumn extends StatefulWidget {
  @override
  _FifthColumnState createState() => _FifthColumnState();

}

class _FifthColumnState extends State with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            _buildText(),
            Switch(value: globals.tracker, onChanged: trackSpeed)
          ],
        ));
  }

  Widget _buildText() {
    if (!globals.tracker) {
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

  void trackSpeed(bool tracking){
    setState(() {
      globals.tracker = tracking;
    });
  }

  @override
  bool get wantKeepAlive => true;
}