import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_strings.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/tasks/components/custom_textfield.dart';
import 'package:todo/views/tasks/components/tasktile.dart';
import 'package:todo/views/tasks/components/time_date_picker.dart';
import 'package:todo/views/tasks/widgets/task_screen_appbar.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen(
      {super.key,
      required this.titleTextController,
      required this.descriptionTextController,
      required this.task});
  final TextEditingController? titleTextController;
  final TextEditingController? descriptionTextController;
  final TaskModel? task;
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  bool isTaskAlreadyExists() {
    if (widget.titleTextController?.text == null &&
        widget.descriptionTextController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  dynamic isTaskAlreadyExitsOtherwiseCreate() {
    if (widget.titleTextController?.text != null &&
        widget.descriptionTextController?.text != null) {
      try {
        widget.titleTextController?.text = title;
        widget.descriptionTextController?.text = subTitle;
        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        updateTaskWarning(context);
        Navigator.pop(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = TaskModel.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time);
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: const TaskScreenAppbar(),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                h20,
                TaskTitle(
                  size: size,
                  isupdate: isTaskAlreadyExists(),
                ),
                h20,
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Title',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                ),
                CustomTextField(
                  onChanged: (String inputTitle) {
                    title = inputTitle;
                  },
                  onFieldSubmitted: (String inputTitle) {
                    title = inputTitle;
                  },
                  size: size,
                  controller: widget.titleTextController,
                ),
                h10,
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                ),
                CustomTextField(
                  onChanged: (String inputSubTitle) {
                    subTitle = inputSubTitle;
                  },
                  onFieldSubmitted: (String inputSubTitle) {
                    subTitle = inputSubTitle;
                  },
                  size: size,
                  controller: widget.descriptionTextController,
                  isDescription: true,
                ),
                h40,
                TimepickerWidget(
                  time: showTime(time),
                  title: AppStrings.timeString,
                  size: size,
                  onTap: () => showModalBottomSheet(
                    backgroundColor: AppColors.white,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: size.width,
                        height: 280,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              h10,
                              TimePickerWidget(
                                initDateTime: time ?? DateTime.now(),
                                dateFormat: 'HH:mm',
                                pickerTheme: DateTimePickerTheme(
                                    itemHeight: 60,
                                    cancelTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey.shade600),
                                    itemTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                    confirmTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primarycolor)),
                                onChange: (dateTime, _) {
                                  setState(() {
                                    time = dateTime;
                                  });
                                },
                                onConfirm: (dateTime, _) {
                                  setState(() {
                                    if (widget.task?.createdAtTime == null) {
                                      time = dateTime;
                                    } else {
                                      widget.task!.createdAtTime = dateTime;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                h40,
                TimepickerWidget(
                  time: showDate(date),
                  title: AppStrings.dateString,
                  size: size,
                  onTap: () => showModalBottomSheet(
                    backgroundColor: AppColors.white,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: size.width,
                        height: 280,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              h10,
                              DatePickerWidget(
                                initialDateTime: date ?? DateTime.now(),
                                onChange: (dateTime, selectedIndex) {
                                  setState(() {
                                    date = dateTime;
                                  });
                                },
                                onConfirm: (dateTime, _) {
                                  setState(() {
                                    if (widget.task?.createdAtDate == null) {
                                      date = dateTime;
                                    } else {
                                      widget.task!.createdAtDate = dateTime;
                                    }
                                  });
                                },
                                minDateTime: DateTime.now(),
                                pickerTheme: DateTimePickerTheme(
                                  itemHeight: 60,
                                  cancelTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                  itemTextStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                  confirmTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.primarycolor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                h40,
                Row(
                  mainAxisAlignment: isTaskAlreadyExists()
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    !isTaskAlreadyExists()
                        ? GestureDetector(
                            onTap: () {
                              deleteTask();
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurStyle: BlurStyle.normal,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey.shade500
                                          : Colors.transparent,
                                      offset: const Offset(6.0, 6.0),
                                      blurRadius: 20.0,
                                      spreadRadius: 5.0,
                                    ),
                                    BoxShadow(
                                      blurStyle: BlurStyle.normal,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white
                                          : Colors.transparent,
                                      offset: const Offset(-6.0, -6.0),
                                      blurRadius: 20.0,
                                      spreadRadius: 5.0,
                                    ),
                                  ],
                                  color: Colors.grey.shade300),
                              width: 150,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Delete Task',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        isTaskAlreadyExitsOtherwiseCreate();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.normal,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey.shade500
                                    : Colors.transparent,
                                offset: const Offset(6.0, 6.0),
                                blurRadius: 20.0,
                                spreadRadius: 5.0,
                              ),
                              BoxShadow(
                                blurStyle: BlurStyle.normal,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.transparent,
                                offset: const Offset(-6.0, -6.0),
                                blurRadius: 20.0,
                                spreadRadius: 5.0,
                              ),
                            ],
                            color: Colors.grey.shade300),
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text(
                            !isTaskAlreadyExists() ? 'Update Task' : 'Add Task',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
