import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}