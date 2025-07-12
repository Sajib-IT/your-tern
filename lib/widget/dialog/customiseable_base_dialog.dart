import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomiseAbleBaseDialog {
  Future<void> showPopup({String? title, required Widget widget}) async {
    await Get.dialog(
        Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    title != null
                        ? Expanded(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 22)))
                        : Spacer(),
                    // Spacer(),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.close, size: 24)),
                  ],
                ),
                SizedBox(height: 16),
                Flexible(child: SingleChildScrollView(child: widget)),
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
