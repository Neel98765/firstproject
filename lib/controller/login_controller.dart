import 'package:firstproject/Tabs/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api_call/api_screen.dart';
import '../commonfiles/colors_file.dart';
import '../commonfiles/constant.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  RxList<LoginModel> loginList = <LoginModel>[].obs;
  late Future<LoginModel> loginObs;
  var isLoading = false.obs;
  var isUserLoggedIn = false.obs;

  void getLoginAPIResponse(String Employee_No, String password) {
    // loginList.clear();
    isLoading(true);
    loginObs = APICall().loginData(Employee_No, password);
    loginObs.then((value) {
      loginList.add(value);
      isLoading(false);
      update();
      if (value.Status.toString() == "1") {
        isUserLoggedIn(true);
        // Get.snackbar('Alert', 'Error',
        //     colorText: AppColors.appSecondaryColor,
        //     backgroundColor: AppColors.appPrimaryColor);
        Get.offAll(() => const DashboardScreen());
      } else {
        Get.snackbar('Alert', 'Error',
            colorText: AppColors.appSecondaryColor,
            backgroundColor: AppColors.appPrimaryColor);
        isUserLoggedIn(false);
      }
    });
  }
}
