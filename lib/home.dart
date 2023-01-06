import 'dart:convert';

import 'package:firstproject/Tabs/punch_screen.dart';
import 'package:firstproject/view/leave_approvals.dart';
import 'package:firstproject/view/leave_form.dart';
import 'package:firstproject/view/leave_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Tabs/punchout_screen.dart';
import 'commonfiles/app_fontsize.dart';
import 'commonfiles/constant.dart';
import 'controller/punch_history_controller.dart';
import 'model/punch_history_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final Employee_No = 0;
  final PunchHistoryController _punchHistoryController =
      Get.put(PunchHistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          InkWell(
            onTap: () async {
              _punchHistoryController.getHistoryResponse(
                  FaceId: GetStorage().read('Employee_No').toString());
              List<PunchHistoryModel> data = [];
              var response =
                  await http.post(Uri.parse(Constant.PUNCH_HISTORY_URL), body: {
                'FaceId': GetStorage().read('Employee_No').toString(),
              });
              var i = 0;
              if (json.decode(response.body).isEmpty) {
                Get.to(PunchingScreen());
              }
              final body = json.decode(response.body);
              for (var item in body) {
                data.add(PunchHistoryModel.fromJSon(item));
                var f1 = DateFormat('MM/dd/yyyy');
                var f2 = f1.parse(item['punchtime']);
                var f3 = DateFormat('MM/dd/yyyy');
                var f4 = f3.format(f2);
                if (i == 0) {
                  if (f4 == DateFormat("MM/dd/yyyy").format(DateTime.now())) {
                    i = 1;
                    Get.to(() => PunchoutScreen());
                  } else {
                    i = 2;
                    Get.to(() => PunchingScreen());
                  }
                }
              }
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/punch.png',
                    height: Get.height / 10,
                  ),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    child: Text('PUNCHING',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize:
                              Get.width / AppFontSize.appTabHeaderTextSize,
                          fontFamily: 'Roboto',
                        ))),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const LeaveRequest());
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/running.png',
                    height: Get.height / 10,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  child: Text('LEAVE REQUEST',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: Get.width / AppFontSize.appTabHeaderTextSize,
                        fontFamily: 'Roboto',
                      ))),
            ],
          ),
          (GetStorage().read('isHOD') == true)
              ? Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => LeaveApprove());
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/check_approval.png',
                          height: Get.height / 10,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: Text('LEAVE APPROVAL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize:
                                  Get.width / AppFontSize.appTabHeaderTextSize,
                              fontFamily: 'Roboto',
                            ))),
                  ],
                )
              : Container()
        ]),
      ),
    );
  }

  showwidget() {}
}
