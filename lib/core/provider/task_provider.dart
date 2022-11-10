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
  Future<List<TaskModel>> getAllTaskById(int noteId) async {
    try {
      listOfTaskProvider = await _taskService.fetchTaskById(noteId);
      notifyListeners();

      return listOfTaskProvider;
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  Future<List<TaskModel>> updateTask(List<TaskModel> snap) async {
    try {
      listOfTaskProvider = snap;
      notifyListeners();

      return [];
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  void takeNoteInfo(NoteModel noteInfoK) {
    noteInfo = noteInfoK;
    notifyListeners();
  }
}
