import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class AppGradientBorderCard extends StatelessWidget {
  const AppGradientBorderCard(
      {super.key,
      required this.gradients,
      required this.child,
      required this.width,
      required this.height,
      this.padding});

  final List<Color> gradients;
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Card(
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
      ),
    );
  }
}
