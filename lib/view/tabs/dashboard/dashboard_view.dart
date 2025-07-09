import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/view/tabs/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController _controller = Get.put(DashboardController());
   DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("DashboardView"),
          Text("DashboardView"),
          Text("DashboardView"),
        ],
      ),
    );
  }
}
