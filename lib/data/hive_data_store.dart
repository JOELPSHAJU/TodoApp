import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/task_model.dart';

class HiveDataStore {
  static const boxName = 'taskBox';

  final Box<TaskModel> box = Hive.box<TaskModel>(boxName);

  //Add new Task
  Future<void> addTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  //Show Task

  Future<TaskModel?> getTask({required String id}) async {
    return box.get(id);
  }

  //Update Task

  Future<void> updateTask({required TaskModel task}) async {
    await task.save();
  }

  //Delete Task

  Future<void> deleteTask({required TaskModel task}) async {
    await task.delete();
  }

  //Listen to changes in Task

  ValueListenable<Box<TaskModel>> listentoTask() => box.listenable();
}
