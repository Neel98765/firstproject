import 'package:firstproject/model/leave_type_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_call/api_screen.dart';

class LeaveTypeController extends GetxController {
  RxList<LeaveTypeModel> leaveList = <LeaveTypeModel>[].obs;
  late Future<List<LeaveTypeModel>?> leaveObs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getleaveAPIResponse(
      Employee_No: GetStorage().read('Employee_No').toString(),
    );
  }

  void getleaveAPIResponse({required String Employee_No}) {
    isLoading(true);
    leaveObs = APICall().leaveData(Employee_No);
    leaveObs.then((value) {
      print(value);
      leaveList.addAll(value!);
      isLoading(false);
    });
  }
}
