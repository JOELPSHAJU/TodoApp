import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_strings.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/views/home/components/floating_button.dart';
import 'package:todo/views/home/components/home_appbar.dart';
import 'package:todo/views/home/components/slider_drawer.dart';
import 'package:todo/views/home/widget/task_tile.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerkey = GlobalKey<SliderDrawerState>();
  dynamic valueOfIndicator(List<TaskModel> tasks) {
    if (tasks.isNotEmpty) {
      return tasks.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<TaskModel> tasks) {
    int i = 0;
    for (var donetask in tasks) {
      if (donetask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    final Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listentoTask(),
        builder: (ctx, Box<TaskModel> box, Widget? child) {
          var task = box.values.toList();
          task.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[300],
              body: SliderDrawer(
                  key: drawerkey,
                  isDraggable: false,
                  animationDuration: 1000,
                  appBar: HomeAppbar(
                    drawerkey: drawerkey,
                  ),
                  slider: const CustomSlider(),
                  child: homeBody(size, base, task)),
              floatingActionButton: const FloatingButton(),
            ),
          );
        });
  }

  SizedBox homeBody(Size size, BaseWidget base, List<TaskModel> tasks) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3, color: Colors.grey.shade300)),
              height: 100,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.mainTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${checkDoneTask(tasks)} of ${tasks.length} Tasks',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation(
                            AppColors.primarycolor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: size.width,
              child: tasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var task = tasks[index];

                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Dismissible(
                            key: Key(task.id),
                            direction: DismissDirection.horizontal,
                            onDismissed: (direction) {
                              setState(() {
                                base.dataStore.deleteTask(task: task);
                              });
                            },
                            background: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.red.withOpacity(.9),
                                  size: 30,
                                ),
                                Text(
                                  AppStrings.deletedTask,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            child: TaskTile(task: task),
                          ),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          notaskFound,
                          width: size.width * .7,
                        ),
                        FadeInUp(
                          from: 30,
                          child: const Text(
                            AppStrings.doneAllTask,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
