import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firstproject/permission_scree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'check_internet_connection_provider.dart';

extension ParseToString on ConnectivityResult {
  String toValue() {
    return toString().split('.').last;
  }
}

class CheckInternetWidget extends StatefulWidget {
  const CheckInternetWidget({Key? key}) : super(key: key);

  @override
  _CheckInternetWidgetState createState() => _CheckInternetWidgetState();
}

class _CheckInternetWidgetState extends State<CheckInternetWidget> {
  CheckInternet? _checkInternet;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  bool isonline = false;
  var result = Connectivity().checkConnectivity();
  Location location = Location();

  @override
  void initState() {
    _initLocationService();
    getConnectivity();
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  Future _initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {}
    }

    var loc = await location.getLocation();
    print("${loc.latitude} ${loc.longitude}");
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Check Internet Connectivity"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Internet Connectivity',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Consumer<CheckInternet>(builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.status,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                  //   Icon(
                  //   provider.status == "Offline"
                  //       ? Icons.cancel
                  //       : Icons.check_circle,
                  //   color: provider.status == "Offline"
                  //       ? Colors.red
                  //       : Colors.green,
                  // );
                }),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                'Location Connectivity',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                ),
                child: const Text('Login'),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  _handleLocationPermission();
                  Location location = Location();
                  bool ison = await location.serviceEnabled();
                  if (!ison) {
                    //if defvice is off
                    bool isturnedon = await location.requestService();
                    if (isturnedon) {
                      Icon(Icons.check_circle);
                      Text("GPS device is turned ON");
                    } else {
                      Text("GPS Device is still OFF");
                    }
                  }
                },
                child: Text("Turn On GPS | Location Package")),
          ],
        ));
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
