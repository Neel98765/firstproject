import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_call/api_screen.dart';
import '../model/emp_leave_view_model.dart';

class LeaveViewController extends GetxController {
  RxList<LeaveViewModel> leaveviewList = <LeaveViewModel>[].obs;
  late Future<List<LeaveViewModel>?> leaveviewObs;
  var isLoading = false.obs;
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    print('arguments>>${argumentData[0]}');
    GetStorage()
        .write('LeaveApplicationNo', argumentData[0]['LeaveApplicationNo']);
    super.onInit();
    getleaveviewAPIResponse(LeaveApplicationNo: "");
  }

  void getleaveviewAPIResponse({required String LeaveApplicationNo}) {
    isLoading(true);
    leaveviewObs = APICall().leaveviewData(LeaveApplicationNo);
    leaveviewObs.then((value) {
      print(value);
      leaveviewList.addAll(value!);
      isLoading(false);
    });
  }
}
