import 'package:firstproject/model/punch_history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_call/api_screen.dart';

class PunchHistoryController extends GetxController {
  RxList<PunchHistoryModel> historyList = <PunchHistoryModel>[].obs;
  late Future<List<PunchHistoryModel>?> historyObs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHistoryResponse(
      FaceId: GetStorage().read('Employee_No').toString(),
    );
  }

  void getHistoryResponse({required String FaceId}) {
    isLoading(true);
    historyList.clear();
    historyObs = APICall().getdisplayquickquote(FaceId);
    historyObs.then((value) {
      historyList.addAll(value!);
      isLoading(false);
      update();
    });
  }
}
