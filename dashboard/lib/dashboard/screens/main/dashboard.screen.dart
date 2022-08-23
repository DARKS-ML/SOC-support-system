import 'package:dashboard/dashboard/screens/main/screen.list.dart';
import 'package:flutter/material.dart';
import 'package:side_bar_custom/side_bar_custom.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBar(
        config: config,
        items: DashboardScreenList.sidebarScreensname,
        children: DashboardScreenList.sidebarScreens,
      ),
    );
  }
}

final config = SideBarConfig(
  backgroundColor: Colors.white,
  selectedBoxColor: Colors.white,
  selectedIconColor: Colors.black,
  dividerColor: Colors.black,
  unselectedBoxColor: Colors.white,
  unselectedIconColor: Colors.grey,
  bottomIconColor: Colors.black,
  iconSize: 20,
  selectedTextStyle: const TextStyle(color: Colors.black),
  unselectedTextStyle: const TextStyle(color: Colors.grey),
  sideBarAnimationDuration: const Duration(milliseconds: 2),
);
