
///
class TaskModel {
  ///
  final int id;

  ///
  bool check;

  ///
  final String task;

  ///
  TaskModel(
    this.id,
    this.task, {
    required this.check,
  });

  @override
  String toString() {
    return 'Todo{id: $id, task: $task, check: $check}';
  }

  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "check": check,
        "task": task,
      };
}