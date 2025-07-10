import 'package:flutter/material.dart';

class UIHelper {
  drawAppbarTitle({required String title, Color? txtColor}) {
    txtColor ??= Colors.white;
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(title,
          style: TextStyle(color: txtColor, fontWeight: FontWeight.w700)),
    );
  }

  Widget columTitleWithWidget({required String title, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        widget,
        const SizedBox(height: 16),
      ],
    );
  }

  drawLine({Color colr = Colors.grey, double h = .0}) {
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: colr,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
