import 'package:firstproject/controller/delete_leave_controller.dart';
import 'package:firstproject/model/leave_pending_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../view/leave_obx_view.dart';

class LeavePendingRaw extends StatelessWidget {
  LeavePendingModel leavePendingModel;

  LeavePendingRaw({Key? key, required this.leavePendingModel})
      : super(key: key);
  final DeleteLeaveController _deleteLeaveController =
      Get.put(DeleteLeaveController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    leavePendingModel.Reason!.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
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
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    leavePendingModel.LeaveType!.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    leavePendingModel.Duration!.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(width: 50),
                InkWell(
                    onTap: () {
                      _deleteLeaveController.getDeleteLeaveResponse(
                        LeaveApplicationNo:
                            leavePendingModel.LeaveApplicationNo!
                        // GetStorage().read('LeaveApplicationNo')
                        ,
                      );
                    },
                    child: Icon(Icons.delete)),
                SizedBox(width: 80),
                InkWell(
                    onTap: () {
                      Get.to(
                        () => Leaveobx(
                          LeaveApplicationNo: null,
                        ),
                        arguments: [
                          {
                            "LeaveApplicationNo":
                                int.parse(leavePendingModel.LeaveApplicationNo!)
                          }
                        ],
                      );
                    },
                    child: Icon(Icons.arrow_forward_ios)),
              ],
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
                    leavePendingModel.FromDate!.toString(),
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
                    leavePendingModel.ToDate!.toString(),
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
      )
    ]);
  }
}
