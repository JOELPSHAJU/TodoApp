import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:todo/views/tasks/task_screen.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
  });
  final TaskModel task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController subtitleTextController = TextEditingController();

  @override
  void initState() {
    titleTextController.text = widget.task.title;
    subtitleTextController.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    subtitleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => TaskScreen(
                    titleTextController: titleTextController,
                    descriptionTextController: subtitleTextController,
                    task: widget.task)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
              boxShadow: widget.task.isCompleted
                  ? [
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade500
                            : Colors.transparent,
                        offset: const Offset(6.0, 3.0),
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                      ),
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.transparent,
                        offset: const Offset(-6.0, -3.0),
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                      ),
                    ]
                  : [
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade500
                            : Colors.transparent,
                        offset: const Offset(6.0, 6.0),
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                      ),
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.transparent,
                        offset: const Offset(-6.0, -6.0),
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                      ),
                    ],
              borderRadius: BorderRadius.circular(8),
              gradient: widget.task.isCompleted
                  ? LinearGradient(colors: AppColors.tilegradientdone)
                  : LinearGradient(colors: AppColors.tilegradientwhite)),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
              },
              child: AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? Colors.transparent
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: widget.task.isCompleted
                            ? AppColors.white
                            : AppColors.grey,
                        width: 2)),
                child: Icon(
                  Icons.check,
                  color: widget.task.isCompleted
                      ? AppColors.white
                      : AppColors.grey,
                ),
              ),
            ),
            title: Text(
              titleTextController.text,
              style: TextStyle(
                  fontSize: 18,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: AppColors.white,
                  fontWeight: FontWeight.w500,
                  color: widget.task.isCompleted
                      ? AppColors.white
                      : AppColors.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitleTextController.text,
                  style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.white,
                      fontWeight: FontWeight.w400,
                      color: widget.task.isCompleted
                          ? AppColors.white
                          : Colors.grey.shade600),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.task.isCompleted
                                ? AppColors.white
                                : Colors.grey.shade600,
                            fontSize: 14),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.task.isCompleted
                                ? AppColors.white
                                : Colors.grey.shade600,
                            fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
