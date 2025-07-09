import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/tabs/tabs_controller.dart';
import 'package:tea_checker/view/tabs/widget/drawer_view.dart';
import 'package:tea_checker/widget/bottom_nav_bar/bottom_nav_bar.dart';

class TabsView extends StatelessWidget {
  final TabsController _controller = Get.put(TabsController());
  TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: DrawerView(),
        appBar: AppBar(
          title: Text(_controller.appbarTitle.value),
          backgroundColor: ColorUtils.primary,
        ),
        body: Obx(() => _controller.pages[_controller.tabIndex.value].page),
        bottomNavigationBar: Obx(
          () => BottomNavBar(
            items: _controller.pages,
            currentIndex: _controller.tabIndex.value,
            function: _controller.changeTabIndex,
          ),
        ),
      ),
    );
  }
}
