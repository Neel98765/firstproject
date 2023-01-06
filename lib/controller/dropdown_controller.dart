// import 'package:firstproject/model/dropdown_model.dart';
// import 'package:firstproject/model/leave_type_model.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../api_call/api_screen.dart';
//
// class DropdownController extends GetxController {
//   RxList<DropdownModel> dropList = <DropdownModel>[].obs;
//   late Future<List<DropdownModel>?> dropObs;
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     gedropdownAPIResponse(
//       MANDT: GetStorage().read('Employee_No').toString(),
//     );
//   }
//
//   void gedropdownAPIResponse({required String MANDT}) {
//     isLoading(true);
//     dropObs = APICall().getdropdown(MANDT);
//     dropObs.then((value) {
//       dropList.addAll(value!);
//       isLoading(false);
//     });
//   }
// }
