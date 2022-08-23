import 'package:flutter/material.dart';
import 'package:side_bar_custom/side_bar_custom.dart';

import 'list_dataset.screen.dart';
import 'overview.screen.dart';

class DashboardScreenList {
  static final sidebarScreens = [
    OverViewScreen(),
    ListDataSetScreen(),
    const Logout(),
  ];
  static final sidebarScreensname = [
    SideBarItem(
      text: "Dashboard",
      icon: Icons.other_houses_sharp,
      tooltipText: "Dashboard page",
    ),
    SideBarItem(
      text: "Others",
      icon: Icons.dashboard,
      tooltipText: "Others page",
    ),
    SideBarItem(
      text: "Logout",
      icon: Icons.exit_to_app,
      tooltipText: "Log Out",
    ),
  ];
}

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Are You Sure ?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
