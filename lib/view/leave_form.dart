import 'dart:convert';
import 'package:firstproject/controller/leave_type_controller.dart';
import 'package:firstproject/raw_file/leave_type_raw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../commonfiles/colors_file.dart';
import '../commonfiles/constant.dart';
import '../controller/leave_form_controller.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({Key? key}) : super(key: key);

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  final LeaveTypeController _leaveTypeController =
      Get.put(LeaveTypeController());
  final LeaveController _leaveController = Get.put(LeaveController());
  TextEditingController fromdateInput = TextEditingController();
  TextEditingController todateInput = TextEditingController();
  TextEditingController reasontype = TextEditingController();

  var selectedVtypes;

  int daysbetween(String from, String to) {
    var date1 = DateTime.parse(from);
    var date2 = DateTime.parse(to);
    Duration diff = date2.difference(date1);
    GetStorage().write('diff.inDays', (diff.inDays + 1));
    return diff.inDays;
  }

  String? selectedName;
  List data = [];
  final List<String> _locations = [
    'Half Day Leave',
    'Full Day Leave'
  ]; // Option 2
  String? _selectedLocation;

  Future getAllName() async {
    var response = await http.post(Uri.parse(Constant.DROP_DOWN_URL), body: {
      'MANDT': GetStorage().read('MANDT').toString(),
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });
  }

  // Duration diff = date1.difference(date2);
  @override
  void initState() {
    fromdateInput.text = ""; //set the initial value of text field
    todateInput.text = ""; //set the initial value of text field
    super.initState();
    getAllName();
    GetStorage().write('diff.inDays', 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Leave Form'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(children: [
          Container(
            padding: EdgeInsets.only(top: Get.height / 30),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Column(children: [
                  Obx(() => _leaveTypeController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width / 20, right: Get.width / 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => LeaveTypeRaw(
                                  leaveTypeModel:
                                      _leaveTypeController.leaveList[index],
                                ),
                                itemCount:
                                    _leaveTypeController.leaveList.length,
                              ),
                            ),
                          ],
                        )),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    alignment: Alignment.topLeft,
                    child: Text("Leave Type",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.appGreyText,
                      //add more colors
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          alignment: Alignment.center,
                          icon: const Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_downward)),
                          dropdownColor: Colors.white,
                          value: selectedName,
                          hint: Text(
                            textAlign: TextAlign.center,
                            'SELECT LEAVE TYPE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto'),
                          ),
                          items: data.map((list) {
                            return DropdownMenuItem(
                              value: list['Text'],
                              child: Text(list['Text'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Get.width / 20,
                                      fontFamily: 'Roboto')),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedName = val as String;
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    alignment: Alignment.topLeft,
                    child: Text("Reasons",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 2.5,
                    child: TextField(
                      controller: reasontype,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.appGreyText,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    alignment: Alignment.topLeft,
                    child: Text("From",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.height / 2.5,
                      child: Center(
                          child: TextField(
                        controller: fromdateInput,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.appGreyText,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              fromdateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                            daysbetween(fromdateInput.text, todateInput.text);
                          } else {}
                        },
                      ))),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    alignment: Alignment.topLeft,
                    child: Text("To",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.height / 2.5,
                      child: Center(
                          child: TextField(
                        controller: todateInput,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.appGreyText,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              todateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                            daysbetween(fromdateInput.text, todateInput.text);
                          } else {}
                        },
                      ))),
                  SizedBox(height: 20),
                  GetStorage().read('diff.inDays') == 1
                      ? Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.height / 2.5,
                              alignment: Alignment.topLeft,
                              child: Text("Leave Option",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto')),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height / 2.5,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.appGreyText,
                                //add more colors
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_downward)),
                                  dropdownColor: Colors.white,
                                  hint: Text('Select Leave Option'),
                                  value: _selectedLocation,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedLocation = newValue as String;
                                    });
                                  },
                                  items: _locations.map((location) {
                                    return DropdownMenuItem(
                                      value: location,
                                      child: Text(location),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          alignment: Alignment.topLeft,
                          child: Text("",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto')),
                        ),
                  Container(
                    width: MediaQuery.of(context).size.height / 2.5,
                    alignment: Alignment.topLeft,
                    child: Text("Duration",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 2.5,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.appGreyText,
                        hintText: GetStorage().read('diff.inDays').toString(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async => {
                      if (reasontype.text.isEmpty)
                        {
                          Get.snackbar('Alert', '',
                              colorText: AppColors.appgreyColor,
                              backgroundColor: AppColors.appPrimaryColor)
                        }
                      else if (fromdateInput.text.isEmpty)
                        {
                          Get.snackbar('Alert', '',
                              colorText: AppColors.appgreyColor,
                              backgroundColor: AppColors.appPrimaryColor)
                        }
                      else if (todateInput.text.isEmpty)
                        {
                          Get.snackbar('Alert', '',
                              colorText: AppColors.appgreyColor,
                              backgroundColor: AppColors.appPrimaryColor)
                        }
                      else
                        {
                          _leaveController.getApprovedLeaveResponse(
                            GetStorage().read('Employee_No').toString(),
                            fromdateInput.text.toString(),
                            todateInput.text.toString(),
                            GetStorage().read('diff.inDays').toString(),
                            selectedName.toString(),
                            _selectedLocation.toString(),
                            GetStorage().read('Contact1').toString(),
                            reasontype.text.toString(),
                            GetStorage().read('MANDT').toString(),
                          ),
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           PunchoutScreen()),
                          // ),
                        }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height / 2.5,
                      padding: EdgeInsets.all(Get.width / 25),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.orangeAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Request Leave',
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
                      width: MediaQuery.of(context).size.height / 2.5,
                      padding: EdgeInsets.all(Get.width / 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                ])),
          )
        ])));
  }
}
