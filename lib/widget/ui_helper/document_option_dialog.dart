import 'dart:io';
import 'package:tea_checker/utils/long_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tea_checker/widget/button/custom_elevated_button.dart';
import 'package:tea_checker/widget/dialog/alert_custom_dialog.dart';
import 'package:tea_checker/widget/dialog/permission_dialog.dart';

class DocumentOptionDialog {
  Future<void> show({required Function(File?) callback}) async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a file',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              Text(
                'Choose your source',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 24),
              CustomElevatedButton(
                text: 'Camera',
                padding: EdgeInsets.symmetric(vertical: 14),
                onPressed: () async {
                  Get.back();
                  callback(await _openCamera());
                },
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                text: 'Gallery',
                padding: EdgeInsets.symmetric(vertical: 14),
                onPressed: () async {
                  Get.back();
                  callback(await _openGallery());
                },
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<File?> _openCamera() async {
    final permission = await _checkForCameraPermission();
    if (!permission) {
      return null;
    }
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      //preferredCameraDevice: (isRear) ? CameraDevice.rear : CameraDevice.front,
    );

    if (pickedFile != null) {
      File path = File(pickedFile.path);
      return path;
    }
    return null;
  }

  Future<File?> _openGallery() async {
    if (Platform.isIOS) {
      final permission = await _checkForGalleryPermission();
      if (!permission) {
        return null;
      }
    }
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File path = File(pickedFile.path);
      return path;
    }
    return null;
  }

  Future<bool> _checkForCameraPermission() async {
    final permission = await Permission.camera.request();
    if (permission.isGranted ||
        permission.isLimited ||
        permission.isProvisional) {
      return true;
    } else if (permission.isDenied) {
      AlertCustomDialogs().showAlert(msg: LongStrings.cameraPermission);
      return false;
    } else {
      PermissionDialog().show(
        title: LongStrings.cameraAccessNeeded,
        permissionMessage: LongStrings.permanentlyDeniedCameraPermission,
      );
      return false;
    }
  }

  Future<bool> _checkForGalleryPermission() async {
    final permission = await Permission.photos.request();
    if (permission.isGranted ||
        permission.isLimited ||
        permission.isProvisional) {
      return true;
    } else if (permission.isDenied) {
      AlertCustomDialogs().showAlert(msg: LongStrings.galleryPermission);
      return false;
    } else {
      PermissionDialog().show(
        title: LongStrings.galleryAccessNeeded,
        permissionMessage: LongStrings.permanentlyDeniedGalleryPermission,
      );
      return false;
    }
  }
}
