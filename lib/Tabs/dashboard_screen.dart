import 'package:firstproject/Tabs/approval_screen.dart';
import 'package:firstproject/Tabs/leave_screen.dart';
import 'package:firstproject/Tabs/punch_screen.dart';
import 'package:firstproject/commonfiles/colors_file.dart';
import 'package:firstproject/controller/punch_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';
import 'logout_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final PunchHistoryController _punchHistoryController =
      Get.put(PunchHistoryController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
  }

  static const List<Widget> _views = [
    HomeTab(),
    LogoutScreen(),
  ];

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.appPrimaryColor,
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Drawer(
                child: ListView(padding: EdgeInsets.all(20), children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Icon(Icons.account_circle, size: 50, color: Colors.grey),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/home_icon.png',
                ),
                title: Text("Home"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.punch_clock),
                  title: Text("Punching"),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PunchingScreen()));
                  }),
              ListTile(
                leading: Image.asset(
                  'assets/images/run.png',
                ),
                title: Text("Leaves"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaveScreen()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/checkbox.png',
                ),
                title: Text("Approval"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ApprovalScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text("Log out"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogoutScreen()));
                },
              ),
            ])),
          ),
          bottomNavigationBar: Container(
            height: 70,
            color: AppColors.appPrimaryColor,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorWeight: 5,
              controller: _tabController,
              tabs: [
                // Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.logout),
                  text: 'Log Out',
                )
              ],
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _views,
            ),
          )),
    );
  }
}
