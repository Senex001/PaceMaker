import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:pacemaker2/bluetooth_widgets.dart';
import 'package:pacemaker2/first_column.dart';
import 'package:pacemaker2/second_column.dart';
import 'package:pacemaker2/third_column.dart';
import 'package:pacemaker2/forth_column.dart';
import 'package:pacemaker2/fifth_column.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;


void main() => runApp(MaterialApp(
  title: 'Pace Maker',
  debugShowCheckedModeBanner: false,
  home: new PaceMaker(),
));

class PaceMaker extends StatefulWidget {



  @override
  _PaceMakerState createState() => new _PaceMakerState();
}

class _PaceMakerState extends State {

  //Bluetooth Variables
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  bool isScanning = false;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  /// Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  //Location Variables

  LocationData _startLocation;
  LocationData _currentLocation;
  double _currentSpeed =0;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
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
                _currentSpeed = result.speed * 1.852;
              });
              _actualFunctionality();
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

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    super.dispose();
  }

  _startScan() {
    _scanSubscription = _flutterBlue
        .scan(
      timeout: const Duration(seconds: 5),
    )
        .listen((scanResult) {
      print('localName: ${scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${scanResult.advertisementData.serviceData}');
      setState(() {
        scanResults[scanResult.device.id] = scanResult;
      });
    }, onDone: _stopScan);

    setState(() {
      isScanning = true;
    });
  }

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  _connect(BluetoothDevice d) async {
    device = d;
    // Connect to device
    deviceConnection = _flutterBlue
        .connect(device, timeout: const Duration(seconds: 4))
        .listen(
      null,
      onDone: _disconnect,
    );

    // Update the connection state immediately
    device.state.then((s) {
      setState(() {
        deviceState = s;
      });
    });

    // Subscribe to connection changes
    deviceStateSubscription = device.onStateChanged().listen((s) {
      setState(() {
        deviceState = s;
      });
      if (s == BluetoothDeviceState.connected) {
        device.discoverServices().then((s) {
          setState(() {
            services = s;
          });
        });
      }
    });
  }

  _disconnect() {
    _writeVibrationCharacteristic([0,0,0,0]);
    // Remove all value changed listeners
    valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    valueChangedSubscriptions.clear();
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    setState(() {
      device = null;
    });
  }

  _writeVibrationCharacteristic(List<int> l) async{
    await device.writeCharacteristic(services.last.characteristics.first, l,
        type: CharacteristicWriteType.withResponse);
    setState(() {});
  }

  /*
  _refreshDeviceState(BluetoothDevice d) async {
    var state = await d.state;
    setState(() {
      deviceState = state;
      print('State refreshed: $deviceState');
    });
  }
*/

  _buildScanningButton() {
    if (isConnected || state != BluetoothState.on) {
      return null;
    }
    if (isScanning) {
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: _stopScan,
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          child: new Icon(Icons.search), onPressed: _startScan);
    }
  }

  _buildScanResultTiles() {
    return scanResults.values
        .map((r) => ScanResultTile(
      result: r,
      onTap: () => _connect(r.device),
    ))
        .toList();
  }

  _buildActionButtons() {
    if (isConnected) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => _disconnect(),
        )
      ];
    }
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }


  _actualFunctionality() {
      if (globals.tracker) {
        if (_currentSpeed < globals.minSpeed) {
          _writeVibrationCharacteristic([0xff,0xff,0xff,0xff]);
          sleep(const Duration(milliseconds:200));
          _writeVibrationCharacteristic([0,0,0,0]);
          sleep(const Duration(milliseconds:200));
          _writeVibrationCharacteristic([0xff,0xff,0xff,0xff]);
          sleep(const Duration(milliseconds:200));
          _writeVibrationCharacteristic([0,0,0,0]);
          sleep(const Duration(milliseconds:200));
        } else if (_currentSpeed > globals.maxSpeed) {
          _writeVibrationCharacteristic([0xff,0xff,0xff,0xff]);
          sleep(const Duration(milliseconds:800));
          _writeVibrationCharacteristic([0,0,0,0]);
          sleep(const Duration(milliseconds:800));
        } else {
          _writeVibrationCharacteristic([0, 0, 0, 0]);
        }
      } else {
        _writeVibrationCharacteristic([0,0,0,0]);
      }
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }
    if (!isConnected) {
      tiles.addAll(_buildScanResultTiles());
    }
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('FlutterBlue'),
          actions: _buildActionButtons(),
        ),
        floatingActionButton: _buildScanningButton(),
        body:
        (!isConnected) ? new Stack(
          children: <Widget>[
            (isScanning) ? _buildProgressBarTile() : new Container(),
            new ListView(
              children: tiles,
            )])
            : new Center(
                child: Column(
                  children: <Widget>[
                    Expanded(child: new Center(
                        child: Text('Your current Speed is ${_currentSpeed}\n'
                    'Device is ${deviceState.toString().split('.')[1]}\n'))),
                    Expanded(child: FirstColumn()),
                    Expanded(child:SecondColumn()),
                    Expanded(child:ThirdColumn()),
                    Expanded(child:ForthColumn()),
                    Expanded(child: FifthColumn()),
                  ],
                ))
        );
  }
}
