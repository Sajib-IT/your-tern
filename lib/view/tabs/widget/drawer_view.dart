import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/auth/sign_in/sign_in_view.dart';
import 'package:tea_checker/view/tabs/tabs_controller.dart';

class DrawerView extends StatelessWidget {
  final TabsController _tabsController = Get.find();
  DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: SizedBox(
        height: Get.height * 97 / 100,
        child: Drawer(
          backgroundColor: ColorUtils.background,
          width: Get.width * 65 / 100,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  _tabsController.userModel.value?.fullName ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  _tabsController.userModel.value?.email ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  // radius: 50,
                  backgroundImage:
                      _tabsController.userModel.value?.profileImageUrl == null
                          ? AssetImage('assets/logo/logo.png')
                          : NetworkImage(
                            _tabsController.userModel.value!.profileImageUrl!,
                          ),
                ),

                decoration: BoxDecoration(color: ColorUtils.cardSurface),
              ),

              ListTile(
                leading: Icon(Icons.group_add, color: ColorUtils.primary),
                title: Text("Create Group", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Get.back();
                  // Get.to(() => AdminFeedback());
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: ColorUtils.primary),
                title: Text("History", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Get.back();
                  // Get.to(() => SearchHistoryView());
                },
              ),
              ListTile(
                leading: Icon(Icons.group, color: ColorUtils.primary),
                title: Text("Group", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Get.back();
                  // Get.to(() => AdminFeedback());
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: ColorUtils.primary),
                title: Text("Help", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Get.back();
                  // Get.to(() => BrowseInfoView());
                },
              ),

              ListTile(
                leading: Icon(Icons.feedback, color: ColorUtils.primary),
                title: Text("Send Feedback", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Handle Request tap
                  // Get.back();
                  // Get.to(() => UserFeedback());
                  // Navigator.pop(context);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //    SnackBar(content: Text("Request clicked")),
                  // );
                },
              ),
              ListTile(
                leading: Icon(Icons.feed, color: ColorUtils.primary),
                title: Text("About us", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Handle Contact tap
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Contact clicked")));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: ColorUtils.primary),
                title: Text("Logout", style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Handle Logout tap
                  Navigator.pop(context);
                  Supabase.instance.client.auth.signOut();
                  Get.offAll(() => SignInView());
                  // Get.delete<SemesterNameController>();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
