
import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final String? imageUrl;
  final IconData? icon;
  final Widget page;

  const TabItem({
    required this.title,
     this.imageUrl,
    required this.page,
     this.icon,
  });
}