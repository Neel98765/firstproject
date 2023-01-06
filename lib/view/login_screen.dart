import 'package:firstproject/Tabs/punch_screen.dart';
import 'package:firstproject/model/login_model.dart';
import 'package:firstproject/Tabs/dashboard_screen.dart';
import 'package:firstproject/commonfiles/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commonfiles/app_fontsize.dart';
import '../commonfiles/colors_file.dart';
import '../commonfiles/constant.dart';
import '../controller/login_controller.dart';
import '../newe.dart';
import 'database screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final usernameNode = FocusNode();
  final passwordNode = FocusNode();
  bool passwordVisible = true;
  final LoginController _loginController = Get.put(LoginController());
  Position? _currentPosition;
  LoginModel? loginModel;
  var sessionManager = SessionManager();
  var Employee_No;

  @override
  void initState() {
    super.initState();
    // _readFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
    // useridController.dispose();
    // passwordController.dispose();
  }

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
      setState(() {});
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => _loginController.isLoading.value
                  ? displayLoader(context)
                  : Container(
                      padding: EdgeInsets.only(top: Get.height / 15),
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(Get.width / 15),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: <Widget>[
                              Text("Welcome",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width / 12,
                                      fontFamily: 'Roboto')),
                              SizedBox(height: Get.width / 25),
                              Text("Sign in to continue",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: Get.width /
                                        AppFontSize.appTabHeaderTextSize,
                                    fontFamily: 'Roboto',
                                  )),
                              SizedBox(height: Get.width / 20),
                              TextField(
                                controller: useridController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.appGreyText,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  hintText: 'User ID',
                                ),
                              ),
                              SizedBox(height: Get.width / 20),
                              TextField(
                                obscureText: passwordVisible,
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (passwordVisible) {
                                          passwordVisible = false;
                                        } else {
                                          passwordVisible = true;
                                        }
                                      });
                                    },
                                    icon: !passwordVisible
                                        ? Icon(
                                            Icons.visibility_outlined,
                                            color: Colors.grey,
                                          )
                                        : Icon(Icons.visibility_off_outlined,
                                            color: Colors.grey),
                                  ),
                                  fillColor: AppColors.appGreyText,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  hintText: 'Password',
                                ),
                              ),
                              SizedBox(height: Get.width / 15),
                              GestureDetector(
                                onTap: () async => {
                                  _getCurrentPosition(),
                                  if (useridController.text.isEmpty)
                                    {
                                      Get.snackbar(
                                          'Alert', 'Please enter user id',
                                          colorText: AppColors.appgreyColor,
                                          backgroundColor:
                                              AppColors.appPrimaryColor)
                                    }
                                  else if (passwordController.text.isEmpty)
                                    {
                                      Get.snackbar(
                                          'Alert', 'Please enter password',
                                          colorText: AppColors.appgreyColor,
                                          backgroundColor:
                                              AppColors.appPrimaryColor)
                                    }
                                  else
                                    {
                                      _loginController.getLoginAPIResponse(
                                        useridController.text.toString(),
                                        passwordController.text.toString(),
                                      ),
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           DashboardScreen()),
                                      // ),
                                    }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(Get.width / 25),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: AppColors.appPrimaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width / 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.width / 15),
                            ],
                          ),
                        ),
                      )),
              // Obx(() => _loginController.isLoading.value
              //     ? displayLoader(context)
              //     : Container())
            )
          ],
        ),
      ),
    );
  }
}
