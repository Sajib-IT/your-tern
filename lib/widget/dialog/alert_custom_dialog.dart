import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AlertCustomDialogs {
  void showSuccess({required String msg, int waitTime = 2}) {
    showBlackEffect();
    _showToast(
        waitTime: waitTime,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 36,
                )),
            const SizedBox(height: 16),
            Text(msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.4,
                )),
            const SizedBox(height: 16),
          ],
        ));
  }

  void showError({required String msg}) {
    showBlackEffect();
    _showToast(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 36,
                )),
            const SizedBox(height: 16),
            Text(msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.4,
                )),
            const SizedBox(height: 16),
          ],
        ));
  }

  void showAlert({required String msg}) {
    showBlackEffect();
    _showToast(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 24,
                child: Icon(
                  Icons.priority_high,
                  color: Colors.white,
                  size: 36,
                )),
            const SizedBox(height: 16),
            Text(msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.4,
                )),
            const SizedBox(height: 16),
          ],
        ));
  }

  void _showToast({required Widget widget, int waitTime = 2}) {
    FToast fToast = FToast();
    fToast.init(Get.context!);
    fToast.showToast(
      child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          elevation: 20,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget,
          )),
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: waitTime),
    );
  }

  void showBlackEffect({int waitTime = 2}){
    showDialog(
      useSafeArea: false,
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return const Dialog();
      },
    );
    Future.delayed(Duration(seconds: waitTime), () {
      Get.back();
    });
  }
}

