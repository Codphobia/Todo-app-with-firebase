class TaskModel {
  late String taskId;
 late int dt;
  late String taskName;
  late String taskTile;

  TaskModel(
      {required this.taskId, required this.dt, required this.taskName, required this.taskTile});

  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'],
      dt: map['dt'],
      taskName: map['taskName'],
      taskTile: map['taskTile'],
    );
  }




}
