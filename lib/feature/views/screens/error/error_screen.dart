import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.errorText});
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              'https://lottie.host/928a09ac-2339-4567-b84d-9514ed52c0ff/xeafbN1y8K.json'),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 75.0, vertical: 20.0),
            child: Text(
              errorText,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
