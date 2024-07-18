import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

class TaskScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.black,
                )),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
