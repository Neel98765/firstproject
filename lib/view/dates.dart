// import 'package:flutter/material.dart';
//
// class Datess extends StatefulWidget {
//   @override
//   State<Datess> createState() => _DatessState();
// }
//
// class _DatessState extends State<Datess> {
//   @override
//   Widget build(BuildContext context) {
//     int daysbetween(DateTime from, DateTime to) {
//       var date1 = DateTime.parse("2022-05-30");
//       var date2 = DateTime.parse("2022-05-31");
//       Duration diff = date1.difference(date2);
//       return diff.inDays;
//     }
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Calculate Difference between DateTime In Flutter App"),
//           backgroundColor: Colors.redAccent,
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(20),
//           child: Column(children: [
//             Text("First Date :$date1"),
//             Text("Second Date :$date2"),
//
//             Text("Difference in Days: ${diff.inDays}"),
//             // Text("Difference in Hours: " + diff.inHours.toString()),
//             // Text("Difference in Minutes: " + diff.inMinutes.toString()),
//             // Text("Difference in Seconds: " + diff.inSeconds.toString()),
//           ]),
//         ));
//   }
// }
