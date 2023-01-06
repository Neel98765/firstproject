// import 'package:firstproject/controller/punch_history_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'history raw file.dart';
//
// class Weather extends StatefulWidget {
//   const Weather({Key? key}) : super(key: key);
//
//   @override
//   State<Weather> createState() => _WeatherState();
// }
//
// class _WeatherState extends State<Weather> {
//   final PunchHistoryController _punchHistoryController =
//       Get.put(PunchHistoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Obx(() => _punchHistoryController.isLoading.value
//                   ? const Center(child: CircularProgressIndicator())
//                   : Padding(
//                       padding: EdgeInsets.only(
//                           left: Get.width / 20, right: Get.width / 20),
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (_, index) => HistoryRaw(
//                           punchHistoryModel:
//                               _punchHistoryController.historyList[index],
//                         ),
//                         itemCount: _punchHistoryController.historyList.length,
//                       ),
//                     )),
//               Container(
//                 child: Text('data'),
//               )
//             ],
//           ),
//         )));
//   }
// }
