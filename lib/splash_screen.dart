import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firstproject/permission_scree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';

extension ParseToString on ConnectivityResult {
  String toValue() {
    return this.toString().split('.').last;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool? _isConnectionSuccessful;
  bool isonline = false;
  var result = Connectivity().checkConnectivity();

  @override
  initState() {
    getConnectivity();
    super.initState();

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
      setState(() {
        _connectivityResult = result;
      });
    });
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

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Connectivity Checker'),
            ),
            body: Column(
              children: [
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Icon(isonline ? Icons.check_circle : Icons.cancel,
                //         color: isonline ? Colors.green : Colors.red),
                //
                //     // Text(
                //     //   isOnline ? 'Connected' : 'Offline',
                //     //   style: TextStyle(
                //     //       fontSize: 30,
                //     //       color: isOnline ? Colors.green : Colors.red),
                //     // ),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      'Internet Connectivity :${_connectivityResult?.toValue()} '),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      Location location = Location();
                      bool ison = await location.serviceEnabled();
                      if (!ison) {
                        //if defvice is off
                        bool isturnedon = await location.requestService();
                        if (isturnedon) {
                          print("GPS device is turned ON");
                        } else {
                          print("GPS Device is still OFF");
                        }
                      }
                    },
                    child: Text("Turn On GPS | Location Package")),
              ],
            )));
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
