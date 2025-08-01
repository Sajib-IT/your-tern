import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';

class ConfirmationDialog {
  Future showDelete({required Function function, String? msg}) async {
    await Get.dialog(
        _getDialog(
            widget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Delete?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, height: 1.4, fontWeight: FontWeight.w700)),
            SizedBox(height: 12),
            Text(msg ?? 'Are you sure you want to delete this member?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.grey)),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: Get.width,
              child: CustomElevatedButton(
                text: 'Delete',
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 14),
                onPressed: () {
                  function();
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: Get.width,
              child: CustomElevatedButton(
                text: 'Cancel',
                backgroundColor: Colors.white,
                textColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 14),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        )),
        barrierDismissible: true);
  }

  Dialog _getDialog({required Widget widget}) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Container(
          padding: EdgeInsets.all(24),
          child: widget,
        ));
  }
}
