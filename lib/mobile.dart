import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_number/mobile_number.dart';

class Simgen extends StatefulWidget {
  const Simgen({Key? key}) : super(key: key);

  @override
  _SimgenState createState() => _SimgenState();
}

class _SimgenState extends State<Simgen> {
  String _mobileNumber = " ";
  final List<SimCard> _simCard = <SimCard>[];
  String? _currentAddress;
  Position? _currentPosition;
  // String? latitude1;
  // String? longitude1;
  // String? Latitude;
  // String? Longitude;
  // var _inputPhone = "+91129998245345";
  // var _checkPhone = "12398245345";


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place
            .subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();

    _getCurrentPosition();
    // printSimCardsData();
    MobileNumber.listenPhonePermission((isPermissionGranted) async {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });
    initMobileNumberState();
  }

  Future<List<SimCard>?> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      // return;
    }
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      final List<SimCard>? simCard = await MobileNumber.getSimCards;
      return simCard;
      // _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    // if (!mounted) return;

    setState(() {
      // _mobileNumber = mobileNumber;
    });
    return null;
  }

  // void printSimCardsData() async {
  //   try {
  //     SimData simData = await SimDataPlugin.getSimData();
  //     for (var s in simData.cards) {
  //       print('Serial number: ${s.serialNumber}');
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint("error! code: ${e.code} - message: ${e.message}");
  //   }
  // }

  // void main() => printSimCardsData();

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) =>
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                  'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim
                      .number}\nCarrier Name: ${sim
                      .carrierName}\nCountry Iso: ${sim
                      .countryIso}\nDisplay Name: ${sim
                      .displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'),
            ],
          ),
        ))
        .toList();
    return Column(children: widgets);
  }
  // double calculateDistance(latitude1, longitude1, Latitude, Longitude) {
  //   var p = 0.01745329519943295;
  //   var c = cos;
  //   var a = 0.5 - c((Longitude - longitude1) * p) / 2 +
  //       c(latitude1 * p) * c(Longitude * p) *
  //           (1 - c((Longitude - longitude1) * p)) / 2;
  //   print('math ${1000 * 12742 * asin(sqrt(a))}');
  //   return 1000 * 12742 * asin(sqrt(a));
  // }
  @override
  Widget build(BuildContext context) {
    print('Latitude ${_currentPosition?.latitude ?? ""}');
    print('LONGITUDE: ${_currentPosition?.longitude ?? ""}');
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Location and sim card'),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text('LATITUDE: ${_currentPosition?.latitude ?? ""}'),
              Text('LONGITUDE: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _getCurrentPosition();
                  // if(_inputPhone.contains(_checkPhone)){
                  //   print('number are same');
                  // }
                  // else{
                  //   print('cancle');
                  // }
                  // calculateDistance(latitude1, longitude1, Latitude, Longitude);
                },
                child: const Text("Get Current Location"),
              ),
              Text('Running on: $_mobileNumber\n'),
              // fillCards(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));

  }


}
