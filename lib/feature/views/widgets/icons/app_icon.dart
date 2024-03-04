import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppIcon extends GetWidget {
  const AppIcon({this.icon, this.size, super.key});

  final IconData? icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: Theme.of(context).iconTheme.color,
    );
  }
}
