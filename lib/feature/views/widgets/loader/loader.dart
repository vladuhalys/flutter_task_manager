import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitPulsingGrid(
              color: context.theme.iconTheme.color!,
              size: context.height * 0.25,
            ),
            const SizedBox(height: 75),
            Text(
              '${LangKeys.loading.tr}...',
              style: context.theme.textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).iconTheme.color,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
