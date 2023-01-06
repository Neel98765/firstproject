// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
//
// class Clock extends StatefulWidget {
//   const Clock({Key? key}) : super(key: key);
//
//   @override
//   _ClockState createState() => _ClockState();
// }
//
// class _ClockState extends State<Clock> {
//   String formattedTime = DateFormat('kk:mm').format(DateTime.now());
//   String hour = DateFormat('a').format(DateTime.now());
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer =
//         Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
//   }
//
//   void _update() {
//     setState(() {
//       formattedTime = DateFormat('kk:mm').format(DateTime.now());
//       hour = DateFormat('a').format(DateTime.now());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(DateFormat("yyyy-MM-dd").format(DateTime.now()),
//                         style: GoogleFonts.lato(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontStyle: FontStyle.normal,
//                             letterSpacing: 5.0)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(DateFormat("hh:mm:ss").format(DateTime.now()),
//                         style: GoogleFonts.lato(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontStyle: FontStyle.normal,
//                             letterSpacing: 5.0)),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Text(formattedTime,
//                   //       style: GoogleFonts.lato(
//                   //           fontSize: 20,
//                   //           color: Colors.black,
//                   //           fontStyle: FontStyle.normal,
//                   //           letterSpacing: 5.0)),
//                   // ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Text(
//                   //     hour,
//                   //     style: GoogleFonts.lato(
//                   //       color: Colors.black,
//                   //       fontSize: 20,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
