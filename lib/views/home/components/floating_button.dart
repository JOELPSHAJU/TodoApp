import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 15,
                    color: Colors.grey.shade300)
              ],
              gradient: LinearGradient(colors: AppColors.tilegradientdone),
              borderRadius: BorderRadius.circular(100)),
          child: const Center(
            child: Icon(
              CupertinoIcons.add,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
