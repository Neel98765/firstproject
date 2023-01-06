import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firstproject/Tabs/dashboard_screen.dart';
import 'package:firstproject/commonfiles/colors_file.dart';
import 'package:firstproject/controller/punch_history_controller.dart';
import 'package:firstproject/controller/punchout_controller.dart';
import 'package:firstproject/model/punch_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../commonfiles/loader.dart';
import '../raw_file/history raw file.dart';

class PunchoutScreen extends StatefulWidget {
  const PunchoutScreen({Key? key}) : super(key: key);

  @override
  State<PunchoutScreen> createState() => _PunchoutScreenState();
}

class _PunchoutScreenState extends State<PunchoutScreen> {
  Position? _currentPosition;
  final PunchoutController _punchoutController = Get.put(PunchoutController());
  final PunchHistoryController _punchHistoryController =
      Get.put(PunchHistoryController());

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

  void updateUI() {
    setState(() {
      _punchHistoryController.getHistoryResponse(
          FaceId: GetStorage().read('Employee_No').toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text('Punching'),
        //   centerTitle: true,
        // ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(children: [
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
                            child: Text("Punch In Time",
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
                                hintText:
                                    GetStorage().read('punchtime').toString(),
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.width / 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Punch Out Date",
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
                              hintText: DateFormat("dd/MM/yyyy")
                                  .format(DateTime.now()),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: Get.width / 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Punch Out Time",
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
                                  DateFormat("hh:mm:ss").format(DateTime.now()),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: Get.width / 20),
                          GestureDetector(
                            onTap: () => {
                              _getCurrentPosition(),
                              if (_currentPosition?.latitude ==
                                  _currentPosition?.longitude)
                                {
                                  Get.snackbar('Alert', 'Location Not Matched',
                                      colorText: AppColors.appgreyColor,
                                      backgroundColor:
                                          AppColors.appPrimaryColor)
                                }
                              else if (_currentPosition?.longitude ==
                                  _currentPosition?.latitude)
                                {
                                  Get.snackbar('Alert', 'Location Not Matched',
                                      colorText: AppColors.appgreyColor,
                                      backgroundColor:
                                          AppColors.appPrimaryColor)
                                }
                              else
                                {
                                  _punchoutController.getPunchoutAPIResponse(
                                    'EmpId',
                                    _currentPosition?.latitude.toString(),
                                    _currentPosition?.longitude.toString(),
                                  ),
                                  _punchHistoryController.getHistoryResponse(
                                      FaceId: GetStorage()
                                          .read('Employee_No')
                                          .toString()),
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.success,
                                    showCloseIcon: true,
                                    // title: 'Success',
                                    desc: 'You are successfully punch out',
                                    descTextStyle:
                                        TextStyle(fontSize: Get.height / 45),
                                    btnOkOnPress: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardScreen()),
                                      );
                                    },
                                    btnOkIcon: Icons.check_circle,
                                  ).show()
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
                                  'Punch Out',
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
                          SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Punch History',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Get.width / 20,
                              ),
                            ),
                          ),
                          Obx(() => _punchHistoryController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: Get.width / 20,
                                      right: Get.width / 20),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) => HistoryRaw(
                                      punchHistoryModel: _punchHistoryController
                                          .historyList[index],
                                    ),
                                    itemCount: _punchHistoryController
                                        .historyList.length,
                                  ),
                                )),
                        ],
                      ))))
        ])));
  }
}
