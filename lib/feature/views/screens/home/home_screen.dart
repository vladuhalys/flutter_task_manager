import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/router/router.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/views/screens/home/widgets/project_item.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      builder: (controller) {
        controller.setCurrentAuthToTableUser();
        controller.getProjects();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              LangKeys.appTitle,
              style: context.theme.textTheme.headlineMedium!.copyWith(
                fontSize: 30,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(
                  child: Text(
                    LangKeys.lang.tr,
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Get.find<LocalizationController>().changeLocale();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    Get.find<ThemeController>().isDark.value
                        ? EvaIcons.sun
                        : EvaIcons.moon,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    Get.find<ThemeController>().changeTheme();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  width: 100,
                  height: 35,
                  child: AppOutlineGradientButton(
                    text: LangKeys.signOut.tr,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: context.theme.textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 14,
                    ),
                    onTap: () async {
                      await Get.find<SupabaseController>().signOut();
                      Get.offAllNamed(AppRouter.authRout);
                    },
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      TextEditingController projectNameController =
                          TextEditingController();
                      Get.dialog(
                        AlertDialog(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          title: Text(
                            LangKeys.createNewProject.tr,
                            style: context.theme.textTheme.headlineMedium!
                                .copyWith(fontSize: 25),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              width: context.width * 0.5,
                              child: AppGradientBorderTextField(
                                hintText: LangKeys.projectName.tr,
                                controller: projectNameController,
                                keyboardType: TextInputType.text,
                                prefixIcon: Icon(
                                  EvaIcons.archive_outline,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                LangKeys.cancel.tr,
                                style: context.theme.textTheme.labelMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.find<SupabaseController>()
                                    .createProject(projectNameController.text);
                                Get.back();
                              },
                              child: Text(
                                LangKeys.ok.tr,
                                style: context.theme.textTheme.headlineMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      surfaceTintColor: Theme.of(context).iconTheme.color,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).iconTheme.color!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: Icon(EvaIcons.plus_circle_outline,
                        color: Theme.of(context).iconTheme.color!),
                    label: Text(
                      LangKeys.createProject.tr,
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).iconTheme.color,
                thickness: 2,
              ),
              (controller.projects.isEmpty)
                  ? Expanded(
                      child: Center(
                        child: Text(
                          LangKeys.noProject.tr,
                          style:
                              context.theme.textTheme.headlineMedium!.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.projects.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ProjectItem(
                              project: controller.projects[index],
                              user: controller.currentUser.value,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
