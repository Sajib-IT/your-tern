import 'package:flutter/material.dart';
import '../../../utils/color_utils.dart';
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? borderRadius;
  final IconData? icon;
  final bool isBorder;

  const CustomElevatedButton(
      {super.key,
        required this.text,
        this.onPressed,
        this.backgroundColor,
        this.textColor,
        this.padding,
        this.fontSize,
        this.borderRadius,
        this.isBorder = false,
        this.icon,
        this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorUtils.primary,
        side: isBorder
            ? BorderSide(
            color: borderColor ?? ColorUtils.primary, width: 2)
            : null,
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        minimumSize: padding != null ? Size.zero : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        shadowColor:
        Colors.transparent, // Remove shadow color to avoid conflicts
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon) : const SizedBox(),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white, // Default text color
              fontSize: fontSize ?? 16.0, // Default font size
            ),
          ),
        ],
      ),
    );
  }
}