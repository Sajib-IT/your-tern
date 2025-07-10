import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'package:tea_checker/view/splash/splash_view_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final SplashViewController controller = Get.put(SplashViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Text(
          'Co-powered by Tech Tinans',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo2.png', height: 175, width: 175),
            const Text(
              'Easy, Peaceful and Mindful life',
              style: TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 70),
            SizedBox(
              width: 70,
              child: LinearProgressIndicator(color: ColorUtils.primary),
            ),
          ],
        ),
      ),
    );
  }
}
