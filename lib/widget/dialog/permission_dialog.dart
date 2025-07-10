import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';

class PermissionDialog {
  Future<void> show(
      {required String title, required String permissionMessage}) async {
    await Get.dialog(
        Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    permissionMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: 'Later',
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                          isBorder: true,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CustomElevatedButton(
                          text: 'Go to settings',
                          padding: EdgeInsets.symmetric(vertical: 14),
                          onPressed: () {
                            Get.back();
                            openAppSettings();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
        barrierDismissible: true);
  }
}
