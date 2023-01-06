import 'package:firstproject/controller/employee_leave_type_controller.dart';
import 'package:firstproject/controller/leave_pending_controller.dart';
import 'package:firstproject/raw_file/Leave_pending_raw.dart';
import 'package:firstproject/raw_file/approved_leave_raw.dart';
import 'package:firstproject/view/leave_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../commonfiles/app_fontsize.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key? key}) : super(key: key);

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  final LeavePendingController _leavePendingController =
      Get.put(LeavePendingController());
  final ApprovedLeaveController _approvedLeaveController =
      Get.put(ApprovedLeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Leave Request'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(children: [
          Container(
              padding: EdgeInsets.only(top: Get.height / 30),
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(Get.width / 30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.topLeft,
                        child: Text('${GetStorage().read('Employee_No')}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width /
                                    AppFontSize.appTabHeaderTextSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto')),
                      ),
                      Divider(
                        height: 10,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.topLeft,
                        child: Text('Leave Pending'),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(LeaveFormScreen());
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.add),
                        ),
                      ),
                      Obx(() => _leavePendingController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width / 20, right: Get.width / 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => LeavePendingRaw(
                                  leavePendingModel: _leavePendingController
                                      .leavependingList[index],
                                ),
                                itemCount: _leavePendingController
                                    .leavependingList.length,
                              ),
                            )),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 10,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        alignment: Alignment.topLeft,
                        child: Text('Approved Leaves'),
                      ),
                      Obx(() => _approvedLeaveController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width / 20, right: Get.width / 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => ApprovedLeaveRaw(
                                  approvedLeaveModel: _approvedLeaveController
                                      .approvedleaveList[index],
                                ),
                                itemCount: _approvedLeaveController
                                    .approvedleaveList.length,
                              ),
                            )),
                    ],
                  ))),
        ])));
  }
}
