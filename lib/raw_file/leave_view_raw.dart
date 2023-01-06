import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commonfiles/colors_file.dart';
import '../model/emp_leave_view_model.dart';

class ListViewRaw extends StatelessWidget {
  LeaveViewModel leaveViewModel;

  ListViewRaw({Key? key, required this.leaveViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.only(top: Get.height / 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.height / 2.5,
                alignment: Alignment.topLeft,
                child: Text("Created By",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: Get.width / 20,
                        fontFamily: 'Roboto')),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.appGreyText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    hintText: leaveViewModel.Employee_Name.toString(),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height / 2.5,
                alignment: Alignment.topLeft,
                child: Text("Created On",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: Get.width / 20,
                        fontFamily: 'Roboto')),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.appGreyText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    hintText: leaveViewModel.FromDate.toString(),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Reason : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: Get.width / 20,
                            fontFamily: 'Roboto')),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(leaveViewModel.Reason.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width / 18,
                              fontFamily: 'Roboto')),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(leaveViewModel.LeaveType.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: Get.width / 20,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(leaveViewModel.Duration.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: Get.width / 20,
                            fontFamily: 'Roboto')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Days',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: Get.width / 20,
                            fontFamily: 'Roboto')),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'From ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      leaveViewModel.FromDate.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Till ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      leaveViewModel.ToDate.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
