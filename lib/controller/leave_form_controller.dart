import 'package:get/get.dart';

import '../api_call/api_screen.dart';
import '../commonfiles/colors_file.dart';
import '../model/leave_form_details_model.dart';
import '../view/leave_request.dart';

class LeaveController extends GetxController {
  RxList<LeaveFormModel> leaveList = <LeaveFormModel>[].obs;
  late Future<LeaveFormModel> leaveObs;
  var isLoading = false.obs;

  void getApprovedLeaveResponse(
      String Employee_No,
      String FromDate,
      String ToDate,
      String Duration1,
      String LeaveType,
      String IsHalfDay,
      String Phone_No,
      String Reason,
      String MANDT) {
    isLoading(true);
    leaveList.clear();
    leaveObs = APICall().leaveformData(Employee_No, FromDate, ToDate, Duration1,
        LeaveType, IsHalfDay, Phone_No, Reason, MANDT);
    leaveObs.then((value) {
      leaveList.add(value);
      isLoading(false);
      update();
      if (value.Status.toString() == "1") {
        Get.snackbar('Alert', 'Leave',
            colorText: AppColors.appSecondaryColor,
            backgroundColor: AppColors.appPrimaryColor);
        Get.offAll(() => const LeaveRequest());
      } else {
        Get.snackbar('Alert', 'Error',
            colorText: AppColors.appSecondaryColor,
            backgroundColor: AppColors.appPrimaryColor);
      }
    });
  }
}
