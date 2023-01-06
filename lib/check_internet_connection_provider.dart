import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckInternet extends ChangeNotifier {
  String status = 'waiting...';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile) {
      status = "- ON";
      notifyListeners();
    } else if (connectionResult == ConnectivityResult.wifi) {
      status = "- ON";
      notifyListeners();
    } else {
      status = "- Off";
      notifyListeners();
    }
  }

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.mobile:
          {
            status = "- ON";
            notifyListeners();
          }
          break;
        case ConnectivityResult.wifi:
          {
            status = "- ON";
            notifyListeners();
          }
          break;
        default:
          {
            status = '- Off';
            notifyListeners();
          }
          break;
      }
    });
  }
}
