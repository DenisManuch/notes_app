import 'dart:convert';

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
          .toList()
        ..sort(((a, b) => a.id.compareTo(b.id)));
    } catch (e) {
      debugPrint('$e');

      return [];
    }
  }

  ///
  Future<void> checkTaskUpdate(int taskId, bool checkValue) async {
    try {
      await supabase.from(task).update(<String, dynamic>{
        'check_task': checkValue,
      }).eq('id', taskId);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> createTask(String title, int noteId) async {
    try {
      await supabase.from(task).insert({'text': title, 'note_id': noteId});
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> upsertTasks(List<TaskModel> listOfTasks) async {
    try {
      final List listToMap;
      print(TaskModel.getListMap(listOfTasks));
      await supabase.from(task).upsert(TaskModel.getListMap(listOfTasks));
      // final listToMap = listOfTasks
      //     .map((e) => TaskModel(e.id, e.task, e.noteId, e.check))
      //     .toList();
      // for (var i in listOfTasks) {

      //   print();
      // }
      // print(listOfTasks.forEach((element) {
      //   element.id;
      // }));
      //listOfTasks.toJson();
      //print(listToMap);
      //await supabase.from(task).upsert();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> deleteTask(int taskId) async {
    try {
      await supabase.from(task).delete().eq('id', taskId);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  TaskModel toTask(Map<String, dynamic> result) {
    return TaskModel(
      int.parse(result['id'].toString()),
      result['text'].toString(),
      int.parse(result['note_id'].toString()),
      result['check_task'] as bool,
    );
  }
}
