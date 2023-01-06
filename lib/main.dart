import 'package:firstproject/view/leave_approvals.dart';
import 'package:firstproject/view/leave_form.dart';
import 'package:firstproject/view/leave_request.dart';
import 'package:firstproject/view/login_screen.dart';
import 'package:firstproject/view/leave_obx_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'Tabs/punchout_screen.dart';
import 'check_internet_connection_provider.dart';
import 'newe.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(
    ChangeNotifierProvider(
        create: (_) => CheckInternet(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Check Internet Connectivity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginScreen(),
    );
  }
}
// int currentIndex = 0;
//
// void navigateToScreens(int index) {
//   currentIndex = index;
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageNewState createState() => _MyHomePageNewState();
// }
//
// class _MyHomePageNewState extends State<MyHomePage> {
//   final List<Widget> viewContainer = [
//     HomeScreen(),
//     Logout()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         drawer: DashboardScreen(),
//         body: IndexedStack(
//           index: currentIndex,
//           children: viewContainer,
//         ),
//         // bottomNavigationBar: BottomNavBar(),
//       ),
//     );
//   }
