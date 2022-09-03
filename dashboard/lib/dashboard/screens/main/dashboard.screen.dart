import 'package:dashboard/dashboard/screens/main/screen.list.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:side_bar_custom/side_bar_custom.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidget.displayDashboardAppbar(context: context),
      body: SideBar(
        config: config,
        items: DashboardScreenList.sidebarScreensname,
        children: DashboardScreenList.sidebarScreens,
      ),
    );
  }
}

final config = SideBarConfig(
  backgroundColor: const Color(0xff16213E),
  selectedBoxColor: Colors.white,
  selectedIconColor: Colors.black,
  dividerColor: Colors.black,
  unselectedBoxColor: const Color(0xff16213E),
  unselectedIconColor: Colors.white,
  bottomIconColor: Colors.black,
  iconSize: 20,
  selectedTextStyle: const TextStyle(color: Colors.black),
  unselectedTextStyle: const TextStyle(color: Colors.grey),
  sideBarAnimationDuration: const Duration(milliseconds: 2),
);
