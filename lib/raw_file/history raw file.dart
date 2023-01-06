import 'package:firstproject/model/punch_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryRaw extends StatelessWidget {
  PunchHistoryModel punchHistoryModel;

  HistoryRaw({Key? key, required this.punchHistoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        child: Row(
          children: [
            Image.asset(
              punchHistoryModel.Status == 'In'
                  ? 'assets/images/bluearrow.png'
                  : 'assets/images/redarrow.png',
              height: Get.height / 25,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                punchHistoryModel.Status!.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto'),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                ' :',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto'),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                punchHistoryModel.punchtime!.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
