import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_fontsize.dart';
import 'colors_file.dart';

Widget displayLoader(BuildContext context) {
  return Container(
    height: Get.height,
    color: const Color(0x33000000),
    alignment: Alignment.center,
    width: Get.width,
    child: Container(
      width: Get.width / 3,
      height: Get.width / 3,
      padding: EdgeInsets.all(Get.width / 30),
      decoration: BoxDecoration(
          color: AppColors.appbackColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: CircularProgressIndicator(
            color: AppColors.appPrimaryColor,
          )),
          SizedBox(
            height: Get.width / 20,
          ),
          Text('Loading...',
              style: TextStyle(
                  fontSize: Get.width / AppFontSize.appRegularTextSize,
                  fontFamily: 'Inter'))
        ],
      ),
    ),
  );
}
