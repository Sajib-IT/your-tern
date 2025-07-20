import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/model/user_model.dart';
import 'package:tea_checker/view/tabs/dashboard/dashboard_view.dart';
import 'package:tea_checker/view/tabs/profile/profile_view.dart';
import 'package:tea_checker/widget/bottom_nav_bar/tab_item.dart';

import 'group/my_groups_view.dart';

class TabsController extends GetxController {
  RxInt tabIndex = RxInt(0);
  RxString appbarTitle = RxString("Dashboard");
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final supabase = Supabase.instance.client;
  @override
  void onInit() async {
    pages = getTabItems();
    await fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    final response = await supabase
        .from('users') // your table name
        .select()
        .eq("id", supabase.auth.currentUser!.id);
    print(response);
    userModel.value = UserModel.fromJson(response[0]);
    print(userModel.value!.fullName);
    // userModel =  response.map((item) => UserModel.fromJson(item)).toList();
  }

  List<TabItem> pages = [];

  List<TabItem> getTabItems() {
    return [
      TabItem(title: "Dashboard", icon: Icons.dashboard, page: DashboardView()),

      TabItem(
        title: "My Groups",
        icon: Icons.group,
        // page: Center(child: Text("ALl Doctors")),
        page: MyGroupsView(),
      ),
      TabItem(
        title: "Notification",
        icon: Icons.notifications,
        page: Center(child: Text("Coming soon")),
      ),
      TabItem(
        title: "Profile",
        icon: Icons.person,
        page: ProfileView(roll: 'patient'),
      ),
    ];
  }

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
