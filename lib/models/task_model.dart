import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtDate,
    required this.createdAtTime,
    required this.isCompleted,
  });

  @HiveField(0) //id
  final String id;
  @HiveField(1) //title
  String title;
  @HiveField(2) //subTitle
  String subTitle;
  @HiveField(3) //createdAtTime
  DateTime createdAtTime;
  @HiveField(4) //createdAtDate
  DateTime createdAtDate;
  @HiveField(5) //isCompleted
  bool isCompleted;

  factory TaskModel.create(
          {required String? title,
          required String? subTitle,
          DateTime? createdAtDate,
          DateTime? createdAtTime}) =>
      TaskModel(
          id: const Uuid().v1(),
          title: title ?? "",
          subTitle: subTitle ?? "",
          createdAtDate: createdAtDate ?? DateTime.now(),
          createdAtTime: createdAtTime ?? DateTime.now(),
          isCompleted: false);
}
