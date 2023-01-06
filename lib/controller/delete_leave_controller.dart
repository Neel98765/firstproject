
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_call/api_screen.dart';
import '../model/delete_leave_model.dart';
import '../model/leave_pending_model.dart';

class DeleteLeaveController extends GetxController {
  RxList<DeleteLeaveModel> deleteList = <DeleteLeaveModel>[].obs;
  late Future <DeleteLeaveModel> deleteObs;
  var isLoading = false.obs;

  void getDeleteLeaveResponse({required String LeaveApplicationNo}) {
    isLoading(true);
    deleteList.clear();
    deleteObs = APICall().deleteData(LeaveApplicationNo);
    deleteObs.then((value) {
      deleteList.add(value);
      isLoading(false);
      update();
    });
  }
}
