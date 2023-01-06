import 'package:firstproject/model/employee_leave_type_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_call/api_screen.dart';

class ApprovedLeaveController extends GetxController {
  RxList<EmployeeLeaveModel> approvedleaveList = <EmployeeLeaveModel>[].obs;
  late Future<List<EmployeeLeaveModel>?> approvedleaveObs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getApprovedLeaveResponse(
      Employee_No: GetStorage().read('Employee_No').toString(),
    );
  }

  void getApprovedLeaveResponse({required String Employee_No}) {
    isLoading(true);
    approvedleaveList.clear();
    approvedleaveObs = APICall().getapprovedleave(Employee_No);
    approvedleaveObs.then((value) {
      approvedleaveList.addAll(value!);
      isLoading(false);
      update();
    });
  }
}
