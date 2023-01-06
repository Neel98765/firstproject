// import 'package:flutter/material.dart';
//
// import '../main.dart';
// enum BottomNavigationBarType {
//   fixed,
//   shifting,
// }
// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     int _selectedIndex = 0;
//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
//         navigateToScreens(index);
//       });
//
//     }
//  return BottomNavigationBar(
//       selectedFontSize: 16,
//       currentIndex: _selectedIndex,
//       selectedItemColor:Colors.yellow,
//       unselectedItemColor: Colors.black45,
//       onTap: _onItemTapped,
//       showUnselectedLabels: false,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.home,
//           ),
//           // title: Text(
//           //   ' Home',
//           // ),
//           backgroundColor: Colors.red,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.thumb_up,
//           ),
//           // title: Text(
//           //   " Likes",
//           // ),
//           backgroundColor: Colors.blue,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.search,
//           ),
//           // title: Text(
//           //   ' Search',
//           // ),
//           backgroundColor: Colors.pink,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.star,
//           ),
//           // title: Text(
//           //   " Profile",
//           // ),
//           backgroundColor: Colors.purple,
//         ),
//       ],
//     );
//     // return BottomNavigationBar(
//     //   items: const <BottomNavigationBarItem>[
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.home),
//     //       // label: Text(
//     //       //   'Home',
//     //       //   style: TextStyle(color: Color(0xFF545454)),
//     //       // ),
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.logout),
//     //       // title: Text(
//     //       //   'Wish List',
//     //       //   style: TextStyle(color: Color(0xFF545454)),
//     //       // ),
//     //     ),
//     //     // BottomNavigationBarItem(
//     //     //   icon: Icon(FontAwesomeIcons.shoppingBag),
//     //     //   title: Text(
//     //     //     'Cart',
//     //     //     style: TextStyle(color: Color(0xFF545454)),
//     //     //   ),
//     //     // ),
//     //     // BottomNavigationBarItem(
//     //     //   icon: Icon(FontAwesomeIcons.dashcube),
//     //     //   title: Text(
//     //     //     'Dashboard',
//     //     //     style: TextStyle(color: Color(0xFF545454)),
//     //     //   ),
//     //     // ),
//     //   ],
//     //   currentIndex: _selectedIndex,
//     //   selectedItemColor: Color(0xFFAA292E),
//     //   onTap: _onItemTapped,
//     // );
//   }
// }
