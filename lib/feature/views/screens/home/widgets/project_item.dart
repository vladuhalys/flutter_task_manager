import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/router/router.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/project.dart';
import 'package:flutter_task_manager/feature/models/user.dart';
import 'package:flutter_task_manager/feature/views/widgets/cards/app_gradient_border_card.dart';
import 'package:flutter_task_manager/feature/views/widgets/dialogs/project_dialog.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key, required this.project, required this.user});
  final Project project;
  final ModelUser user;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      builder: (controller) {
        return InkWell(
          onTap: () {
            controller.currentProject.value = project;
            controller.getTables();
            Get.toNamed(AppRouter.project);
          },
          child: AppGradientBorderCard(
            width: double.infinity,
            height: 80.0,
            gradients: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LangKeys.project.tr} "${project.projectName}"',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 20,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      user.userName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(width: 20.0),
                    InkWell(
                      onTap: () {
                        Get.dialog(
                            AppProjectDialog(isEdit: true, project: project));
                      },
                      child: Icon(HeroIcons.pencil,
                          size: 30.0, color: Theme.of(context).iconTheme.color),
                    ),
                    const SizedBox(width: 20.0),
                    InkWell(
                      onTap: () {
                        controller.deleteProject(project.id);
                      },
                      child: Icon(HeroIcons.x_circle,
                          size: 30.0, color: AppColors.textError),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
