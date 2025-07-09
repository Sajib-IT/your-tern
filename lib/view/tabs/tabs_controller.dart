import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/view/tabs/dashboard/dashboard_view.dart';
import 'package:tea_checker/widget/bottom_nav_bar/tab_item.dart';

class TabsController extends GetxController {
  RxInt tabIndex = RxInt(0);
  RxString appbarTitle = RxString("Dashboard");

  List<TabItem> pages = [
    TabItem(title: "Dashboard", icon: Icons.dashboard, page: DashboardView()),

    TabItem(
      title: "Groups",
      icon: Icons.group,
      page: Center(child: Text("ALl Doctors")),
    ),
    TabItem(
      title: "Notification",
      icon: Icons.notifications,
      page: Center(child: Text("ALl PTEiNES FOR DOCTOR")),
    ),
    TabItem(
      title: "Profile",
      icon: Icons.person,
      page: Center(child: Text("profile")),
    ),
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      appbarTitle.value = "Dashboard";
    } else if (index == 1) {
      appbarTitle.value = "Group";
    } else if (index == 2) {
      appbarTitle.value = "Notification";
    } else if (index == 3) {
      appbarTitle.value = "Profile";
    }
  }
}
