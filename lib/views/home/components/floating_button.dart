import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/views/tasks/task_screen.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key, 
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => TaskScreen(
                    titleTextController: null,
                    descriptionTextController: null,
                    task: null)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primarycolor,
              borderRadius: BorderRadius.circular(100)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
