import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:notes_app/core/supabase_services/task_service.dart';

///
class TaskProvider extends ChangeNotifier {
  ///
  final TaskService _taskService = TaskService();

  ///
  int noteIdProvider = 0;

  ///
  NoteModel? noteInfo;

  ///

  ///
  List<TaskModel> listOfTaskProvider = [];

  ///
  List<TaskModel> get getTaskListProvider => listOfTaskProvider;

  ///
  Future<List<TaskModel>> getAllTaskById(NoteModel note) async {
    try {
      noteInfo = note;
      listOfTaskProvider = await _taskService.fetchTaskById(note.id);
      notifyListeners();

      return listOfTaskProvider;
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  Future<void> updateTask(int taskId, bool checkValue, int noteId) async {
    try {
      await _taskService.checkTaskUpdate(taskId, checkValue);
      listOfTaskProvider = await _taskService.fetchTaskById(noteId);
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> deleteTask(int taskId, int noteId) async {
    try {
      await _taskService.deleteTask(taskId);
      listOfTaskProvider = await _taskService.fetchTaskById(noteId);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> clearListOfTasks() async {
    listOfTaskProvider.clear();
    notifyListeners();
  }
}
