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
  TaskModel(
    this.id,
    this.task, this.noteId, this.check,);

  @override
  String toString() {
    return 'Todo{id: $id, task: $task, check: $check, noteId: $noteId}';
  }

  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "check_task": check,
        "task": task,
        "note_id": noteId,
      };
///
      Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': task,
      'check_task': check,
      'note_id': noteId,
    };
  }
///
  static dynamic getListMap(List<dynamic> items) {
    final List<Map<String, dynamic>> list = [];
    for (final element in items) {
      list.add(element.toMap() as Map<String, dynamic>);
    }
    
    return list;
  }
}
