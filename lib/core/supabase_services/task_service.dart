import 'package:flutter/material.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class TaskService {
  /// table name
  static const task = 'tasks_list';

  /// shortcut
  final supabase = Supabase.instance.client;

  /// Fetch all notes from supabase
  Future<List<TaskModel>> fetchTaskById(int noteId) async {
    try {
      final List<dynamic> respons = await supabase
          .from(task)
          .select<List<dynamic>>('*')
          .eq('note_id', noteId);

      return respons
          .map((dynamic e) => toTask(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('$e');

      return [];
    }
  }

  ///
  TaskModel toTask(Map<String, dynamic> result) {
    return TaskModel(
      int.parse(result['id'].toString()),
      check: result['check_task'] as bool,
      result['text'].toString(),
    );
  }
}
