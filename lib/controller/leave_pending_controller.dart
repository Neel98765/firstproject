import 'package:firstproject/model/punch_history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_call/api_screen.dart';
import '../model/leave_pending_model.dart';

class LeavePendingController extends GetxController {
  RxList<LeavePendingModel> leavependingList = <LeavePendingModel>[].obs;
  late Future<List<LeavePendingModel>?> pendingObs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLeavePendingResponse(
      Employee_No: GetStorage().read('Employee_No').toString(),
    );
  }

  void getLeavePendingResponse({required String Employee_No}) {
    isLoading(true);
    leavependingList.clear();
    pendingObs = APICall().getleavepending(Employee_No);
    pendingObs.then((value) {
      leavependingList.addAll(value!);
      isLoading(false);
      update();
    });
  }
}
