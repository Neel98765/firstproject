import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/leave_view_controller.dart';
import '../model/emp_leave_view_model.dart';
import '../raw_file/leave_view_raw.dart';

class Leaveobx extends StatefulWidget {
  var LeaveApplicationNo;

  Leaveobx({Key? key, required this.LeaveApplicationNo}) : super(key: key);

  @override
  State<Leaveobx> createState() => _LeaveobxState();
}

class _LeaveobxState extends State<Leaveobx> {
  final LeaveViewController _leaveViewController =
      Get.put(LeaveViewController());

  @override
  Widget build(BuildContext context) {
    // print('object${widget.LeaveApplicationNo}');
    // GetStorage().write('LeaveApplicationNo', widget.LeaveApplicationNo);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Leave Details'),
              centerTitle: true,
            ),
            body: Column(children: [
              // Text('${widget.LeaveApplicationNo}'),
              Obx(() => _leaveViewController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 20, right: Get.width / 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => ListViewRaw(
                          leaveViewModel:
                              _leaveViewController.leaveviewList[index],
                        ),
                        itemCount: _leaveViewController.leaveviewList.length,
                      ),
                    )),
            ])));
  }
}
