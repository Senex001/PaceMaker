import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class SpeedTracker extends StatefulWidget {


  @override
  _SpeedTrackerState createState() => _SpeedTrackerState();
}

class _SpeedTrackerState extends State{

  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          print("Location: ${location.latitude}");
          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) {
            if(mounted){
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }



  //test area end

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: _buildText()
    );
  }

  Widget _buildText() {
       return new Text((_currentLocation != null
          ? 'Current Speed: ${_currentLocation.speed}\n'
          : 'Error: $error\n'),
        style: TextStyle(fontSize: 20),
      );
    }
}

