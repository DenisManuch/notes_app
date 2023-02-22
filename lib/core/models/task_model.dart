///
class TaskModel {
  ///
  final int id;

  ///
  bool check;

  ///
  String task;

  ///
  final int noteId;
///
  String idStr = 'id';
///
  String checkStr = 'check_task';
///
  String taskStr = 'text';
///
  String noteStr = 'note_id';

  ///
  TaskModel(
    this.id,
    this.task,
    this.noteId, {
    required this.check,
  });

  @override
  String toString() {
    return 'Todo{id: $id, task: $task, check: $check, noteId: $noteId}';
  }

  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
        idStr: id,
        checkStr: check,
        taskStr: task,
        taskStr: noteId,
      };

  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      idStr: id,
      checkStr: check,
      taskStr: task,
      noteStr: noteId,
    };
  }

  ///
  static dynamic getListMap(List<dynamic> items) {
    final List<Map<String, dynamic>> list = [];
    for (final element in items) {
      list.add(
        element.toString() as Map<String, dynamic>,
      ); // return to this problem
    }

    return list;
  }
}
