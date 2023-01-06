import 'package:get/get.dart';

import '../api_call/api_screen.dart';
import '../model/punchout_model.dart';

class PunchoutController extends GetxController {
  RxList<PunchOutModel> punchoutList = <PunchOutModel>[].obs;
  late Future<PunchOutModel> punchoutObs;
  var isLoading = false.obs;

  void getPunchoutAPIResponse(
      dynamic EmpId, dynamic latitude, dynamic longitude) {
    punchoutList.clear();
    isLoading(true);
    punchoutObs = APICall().punchoutData(EmpId, latitude, longitude);
    punchoutObs.then((value) {
      punchoutList.add(value);
      isLoading(false);
    });
  }
}
