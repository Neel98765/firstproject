import 'package:firstproject/Tabs/punchout_screen.dart';
import 'package:get/get.dart';

import '../api_call/api_screen.dart';
import '../commonfiles/colors_file.dart';
import '../model/punchin_model.dart';

class PunchinController extends GetxController {
  RxList<PunchInModel> punchinList = <PunchInModel>[].obs;
  late Future<PunchInModel> punchinObs;
  var isLoading = false.obs;

  void getPunchinAPIResponse(
      dynamic EmpId, dynamic latitude, dynamic longitude) {
    punchinList.clear();
    isLoading(true);
    punchinObs = APICall().punchinData(EmpId, latitude, longitude);
    punchinObs.then((value) {
      punchinList.add(value);
      isLoading(false);
      update();
      if (value.Status.toString() == "1") {
        Get.snackbar('Alert', 'Punchout',
            colorText: AppColors.appSecondaryColor,
            backgroundColor: AppColors.appPrimaryColor);
        Get.offAll(() => const PunchoutScreen());
      } else {
        Get.snackbar('Alert', 'Error',
            colorText: AppColors.appSecondaryColor,
            backgroundColor: AppColors.appPrimaryColor);
      }
    });
  }
}
