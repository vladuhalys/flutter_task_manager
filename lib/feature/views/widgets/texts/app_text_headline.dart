import 'package:flutter/material.dart';

///Text Headline - large text
class AppTextHeadline extends StatelessWidget {
  const AppTextHeadline({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineMedium);
  }
}
