import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_strings.dart';
import 'package:todo/utils/constants.dart';
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
      } catch (e) {
        updateTaskWarning(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = TaskModel.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time);
        BaseWidget.of(context).dataStore.addTask(task: task);
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
        appBar: const TaskScreenAppbar(),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              h20,
              TaskTitle(
                size: size,
                isupdate: isTaskAlreadyExists(),
              ),
              h20,
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
              h20,
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
                              initDateTime: showDateAsDateTime(time),
                              dateFormat: 'HH:mm',
                              pickerTheme: const DateTimePickerTheme(
                                  itemHeight: 60,
                                  cancelTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.grey),
                                  itemTextStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black),
                                  confirmTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.primarycolor)),
                              onChange: (dateTime, _) {},
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
                                initialDateTime: showDateAsDateTime(date),
                                onChange: (dateTime, selectedIndex) {},
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
                                pickerTheme: const DateTimePickerTheme(
                                    itemHeight: 60,
                                    cancelTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.grey),
                                    itemTextStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black),
                                    confirmTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primarycolor)))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              h20,
              Row(
                mainAxisAlignment: isTaskAlreadyExists()
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  !isTaskAlreadyExists()
                      ? SizedBox(
                          width: 122,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              height: 50,
                              minWidth: 120,
                              color: AppColors.primarycolor,
                              child: Center(
                                child: Text(
                                  'Delete Task',
                                ),
                              ),
                              onPressed: () {
                                deleteTask();
                                Navigator.pop(context);
                              }),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 122,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        minWidth: 120,
                        color: AppColors.primarycolor,
                        child: Center(
                          child: Text(
                            !isTaskAlreadyExists() ? 'Update Task' : 'Add Task',
                          ),
                        ),
                        onPressed: () {
                          isTaskAlreadyExitsOtherwiseCreate();
                          Navigator.pop(context);
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimepickerWidget extends StatelessWidget {
  const TimepickerWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.title,
    required this.time,
  });
  final String title;
  final VoidCallback onTap;
  final Size size;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 8),
          width: size.width,
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 215, 215),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    time,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.size,
      required this.controller,
      this.isDescription = false,
      required this.onFieldSubmitted,
      required this.onChanged});

  final Size size;
  final TextEditingController? controller;
  final bool isDescription;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        title: TextFormField(
          cursorHeight: isDescription ? 20 : 40,
          cursorColor: AppColors.primarycolor,
          cursorWidth: 2,
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          maxLines: isDescription ? 2 : 4,
          minLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: !isDescription ? size.width * .06 : 15,
              decoration: TextDecoration.none),
          decoration: InputDecoration(
            prefixIcon: isDescription
                ? const Icon(
                    Icons.bookmark_border_outlined,
                    color: AppColors.primarycolor,
                  )
                : null,
            contentPadding: EdgeInsets.only(left: isDescription ? 0 : 10),
            hintText: isDescription ? 'Add description' : 'Add Title..',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarycolor, width: 2),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarycolor),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTitle extends StatelessWidget {
  const TaskTitle({super.key, required this.size, required this.isupdate});

  final Size size;
  final bool isupdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * .2,
              child: const Divider(),
            ),
            RichText(
              text: TextSpan(
                  text:
                      ' ${isupdate ? AppStrings.addNewTask : AppStrings.updateTaskString} ',
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * .06),
                  children: [
                    TextSpan(
                        text: '${AppStrings.taskText} ',
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * .06))
                  ]),
            ),
            SizedBox(
              width: size.width * .2,
              child: const Divider(),
            )
          ],
        ),
        h10,
        const Text(
          AppStrings.titleTextField,
          style: TextStyle(fontSize: 14, color: AppColors.primarycolor),
        ),
      ],
    );
  }
}
