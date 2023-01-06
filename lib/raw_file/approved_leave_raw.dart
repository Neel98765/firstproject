import 'package:firstproject/model/employee_leave_type_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/leave_view_controller.dart';
import '../view/leave_obx_view.dart';

class ApprovedLeaveRaw extends StatelessWidget {
  EmployeeLeaveModel approvedLeaveModel;

  ApprovedLeaveRaw({Key? key, required this.approvedLeaveModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      approvedLeaveModel.Reason!.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    ' - ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ),
                Text(
                  approvedLeaveModel.LeaveType!.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          approvedLeaveModel.Duration!.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Days',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Leaveobx(
                              LeaveApplicationNo: null,
                            ),
                            arguments: [
                              {
                                "LeaveApplicationNo": int.parse(
                                    approvedLeaveModel.LeaveApplicationNo!)
                              }
                            ],
                          );
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
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
                    approvedLeaveModel.FromDate!.toString(),
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
                    approvedLeaveModel.ToDate!.toString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
