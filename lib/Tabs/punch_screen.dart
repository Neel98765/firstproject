import 'dart:math';

import 'package:firstproject/Tabs/punchout_screen.dart';
import 'package:firstproject/commonfiles/colors_file.dart';
import 'package:firstproject/model/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../commonfiles/loader.dart';
import '../controller/punchin_controller.dart';

class PunchingScreen extends StatefulWidget {
  PunchingScreen({Key? key}) : super(key: key);

  @override
  State<PunchingScreen> createState() => _PunchingScreenState();
}

class _PunchingScreenState extends State<PunchingScreen> {
  Position? _currentPosition;
  LoginModel? loginModel;
  final PunchinController _punchinController = Get.put(PunchinController());

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
      setState(() {});
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 1000 * 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _punchinController.isLoading.value
        ? displayLoader(context)
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Punching'),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Get.height / 15),
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(Get.width / 15),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Date",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Get.width / 20,
                                      fontFamily: 'Roboto')),
                            ),
                            Container(
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.appGreyText,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  hintText: DateFormat("dd/MM/yyyy")
                                      .format(DateTime.now()),
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Time",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Get.width / 20,
                                      fontFamily: 'Roboto')),
                            ),
                            TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.appGreyText,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                hintText: DateFormat("hh:mm:ss")
                                    .format(DateTime.now()),
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Latitude",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Get.width / 20,
                                      fontFamily: 'Roboto')),
                            ),
                            TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.appGreyText,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                hintText: '${_currentPosition?.latitude ?? ""}',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Longitude",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Get.width / 20,
                                      fontFamily: 'Roboto')),
                            ),
                            TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.appGreyText,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                hintText:
                                    '${_currentPosition?.longitude ?? ""}',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                            GestureDetector(
                              onTap: () async => {
                                _getCurrentPosition(),
                                if (_currentPosition?.latitude ==
                                    _currentPosition?.longitude)
                                  {
                                    Get.snackbar(
                                        'Alert', 'Location Not Matched',
                                        colorText: AppColors.appgreyColor,
                                        backgroundColor:
                                            AppColors.appPrimaryColor)
                                  }
                                else if (_currentPosition?.longitude ==
                                    _currentPosition?.latitude)
                                  {
                                    Get.snackbar(
                                        'Alert', 'Location Not Matched',
                                        colorText: AppColors.appgreyColor,
                                        backgroundColor:
                                            AppColors.appPrimaryColor)
                                  }
                                else
                                  {
                                    _punchinController.getPunchinAPIResponse(
                                      'EmpId',
                                      _currentPosition?.latitude.toString(),
                                      _currentPosition?.longitude.toString(),
                                    ),
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PunchoutScreen()),
                                    // ),
                                  }
                              },
                              child: Container(
                                padding: EdgeInsets.all(Get.width / 25),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.orangeAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Punch in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width / 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                            GestureDetector(
                              onTap: () => {},
                              child: Container(
                                padding: EdgeInsets.all(Get.width / 25),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AppColors.appPrimaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width / 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
