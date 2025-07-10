import 'package:flutter/material.dart';

class FakeInputField extends StatelessWidget {
  final String text;
  final isHint;
  final Color bgColor;
  final IconData? icon;
  final bool isIconPrefix;

  // final bool showDateIcon;
  const FakeInputField(
      {super.key,
      required this.text,
      this.isHint = false,
      this.bgColor = Colors.white,
      this.icon,
      this.isIconPrefix = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: bgColor,
          borderRadius: BorderRadius.circular(8)),
      child: icon != null
          ? isIconPrefix
              ? Row(
                  children: [
                    Icon(icon, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    _getTextWidget(text),
                  ],
                )
              : Row(
                  children: [
                    _getTextWidget(text),
                    const Spacer(),
                    Icon(icon, size: 16, color: Colors.grey),
                  ],
                )
          : _getTextWidget(text),
    );
  }

  Widget _getTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isHint ? Colors.grey : Colors.black),
    );
  }
}
