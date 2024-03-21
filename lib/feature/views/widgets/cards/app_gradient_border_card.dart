import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class AppGradientBorderCard extends StatelessWidget {
  const AppGradientBorderCard(
      {super.key,
      required this.gradients,
      required this.child,
      required this.width,
      required this.height});

  final List<Color> gradients;
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(colors: gradients),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(20),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
