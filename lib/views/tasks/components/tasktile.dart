import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_strings.dart';
import 'package:todo/utils/constants.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({super.key, required this.size, required this.isupdate});

  final Size size;
  final bool isupdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text:
                      ' ${isupdate ? AppStrings.addNewTask : AppStrings.updateTaskString} ',
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * .08),
                  children: [
                    TextSpan(
                        text: '${AppStrings.taskText} ',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * .08))
                  ]),
            ),
          ],
        ),
        h10,
      ],
    );
  }
}
