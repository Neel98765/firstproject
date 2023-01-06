import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_call/api_screen.dart';
import '../model/hod_leave_approval_model.dart';

class HodLeaveViewController extends GetxController {
  RxList<HodLeaveApproveModel> hodleaveviewList = <HodLeaveApproveModel>[].obs;
  late Future<List<HodLeaveApproveModel>?> hodleaveviewObs;
  var isLoading = false.obs;
  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    // print('arguments>>${argumentData[0]}');
    // GetStorage()
    //     .write('LeaveApplicationNo', argumentData[0]['LeaveApplicationNo']);
    super.onInit();
    gethodleaveviewAPIResponse(
      HOD: GetStorage().read('Employee_No'),
    );
  }

  void gethodleaveviewAPIResponse({required int HOD}) {
    isLoading(true);
    hodleaveviewObs = APICall().hodleaveviewData(HOD);
    hodleaveviewObs.then((value) {
      print(value);
      hodleaveviewList.addAll(value!);
      isLoading(false);
    });
  }
}
